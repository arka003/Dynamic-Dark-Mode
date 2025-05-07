//
//  AppDelegate.swift
//  DynamicLauncher
//
//  Created by Apollo Zhu on 6/9/18.
//  Copyright © 2018-2022 Dynamic Dark Mode. All rights reserved.
//

import Cocoa

let id = "io.github.apollozhu.Dynamic"

var noInstanceRunning: Bool {
    return NSRunningApplication
        .runningApplications(withBundleIdentifier: id)
        .filter { $0.isActive }
        .isEmpty
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        defer { NSApp.terminate(nil) }
        guard noInstanceRunning else { return }
        
        // Get URL for the app bundle
        guard let appURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: id) else {
            print("Failed to find app URL for bundle identifier: \(id)")
            return
        }
        
        let configuration = NSWorkspace.OpenConfiguration()
        
        NSWorkspace.shared.openApplication(at: appURL, configuration: configuration) { app, error in
            if let error = error {
                print("Failed to launch app: \(error.localizedDescription)")
            }
        }
    }
}
