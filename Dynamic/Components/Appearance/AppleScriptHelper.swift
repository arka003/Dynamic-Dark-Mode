//
//  AppleScriptHelper.swift
//  Dynamic Dark Mode
//
//  Created by Apollo Zhu on 6/7/18.
//  Copyright © 2018-2022 Dynamic Dark Mode. All rights reserved.
//

import Cocoa

// MARK: - All Apple Scripts

public enum AppleScript: String, CaseIterable {
    case toggleDarkMode = "not dark mode"
    case enableDarkMode = "true"
    case disableDarkMode = "false"
}

// MARK: - Execution

extension AppleScript {
    public func execute() {
        let frontmostApplication = NSWorkspace.shared.frontmostApplication
        AppleScript.requestPermission { authorized in
            defer { frontmostApplication?.activate(options: [.activateIgnoringOtherApps]) }
            
            if authorized {
                self.useAppleScriptImplementation()
            } else {
                self.useNonAppStoreCompliantImplementation()
            }
        }
    }
    
    // MARK: Deprecated API
    
    /// Turns dark mode on/off/to the opposite.
    private var source: String {
        return """
        tell application "System Events"
            tell appearance preferences to set dark mode to \(rawValue)
        end tell
        """
    }
    
    private func useAppleScriptImplementation() {
        var errorInfo: NSDictionary? = nil
        NSAppleScript(source: self.source)!
            .executeAndReturnError(&errorInfo)
        // Handle errors
        if errorInfo != nil {
            useNonAppStoreCompliantImplementation()
        }
    }
    
    // MARK: Private API
    
    private func useNonAppStoreCompliantImplementation() {
        switch self {
        case .toggleDarkMode:
            SLSSetAppearanceThemeLegacy(!SLSGetAppearanceThemeLegacy())
        case .enableDarkMode:
            SLSSetAppearanceThemeLegacy(true)
        case .disableDarkMode:
            SLSSetAppearanceThemeLegacy(false)
        }
    }
}

// MARK: - Permission

extension AppleScript {
    public static let notAuthorized = NSLocalizedString(
        "AppleScript.authorization.error",
        value: "You didn't allow Dynamic Dark Mode to manage dark mode",
        comment: ""
    )
    
    public static func redirectToSystemPreferences() {
        openURL("x-apple.systempreferences:com.apple.preference.security?Privacy_Automation")
    }
    
    public static func requestPermission(
        retryOnInternalError: Bool = true,
        then process: @escaping Handler<Bool>
    ) {
        DispatchQueue.global().async {
            let systemEvents = "com.apple.systemevents"
            
            // Find System Events application URL using modern API
            let appURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: systemEvents)
                ?? URL(fileURLWithPath: "/System/Library/CoreServices/System Events.app")
            
            // Configure the launch options
            let configuration = NSWorkspace.OpenConfiguration()
            
            // Launch System Events app
            NSWorkspace.shared.openApplication(at: appURL,
                                              configuration: configuration) { app, error in
                if let error = error {
                    remindReportingBug("Failed to launch System Events: \(error.localizedDescription)")
                    if retryOnInternalError {
                        requestPermission(retryOnInternalError: false, then: process)
                        return
                    }
                    process(false)
                    return
                }
                
                // Now that System Events is running, check automation permission
                let target = NSAppleEventDescriptor(bundleIdentifier: systemEvents)
                let status = AEDeterminePermissionToAutomateTarget(
                    target.aeDesc, typeWildCard, typeWildCard, true
                )
                
                switch Int(status) {
                case Int(noErr):
                    process(true)
                case errAEEventNotPermitted:
                    process(false)
                case errOSAInvalidID, -1751,
                     errAEEventWouldRequireUserConsent,
                     procNotFound:
                    if retryOnInternalError {
                        requestPermission(retryOnInternalError: false, then: process)
                    } else {
                        process(false)
                    }
                default:
                    remindReportingBug("OSStatus \(status)")
                    process(false)
                }
            }
        }
    }

}
