# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [1.5.2] - 2025-04-21
### Added
- Apple Silicon Support

## [1.5.2] - 2019-09-23
### Changed
- Switches dark mode with SkyLight when missing AppleScript permission
- Behavior of buttons to adapt to system schedule
- Updated French translation

### Fixed
- Wrong sunset/sunrise date when UTC time is in next day
- Version number now works with Sparkle

## [1.5.1] - 2019-09-18
### Added
- Import Spanish translations from Crowdin
- Option to skip setup and AppleScript permission check (#75)

### Changed
- Only reschedules when connection is not expensive and not in low data mode

### Fixed
- Update for screen brightness should be more reliable 
- Now detects system auto appearance on launch to set appropriate schedule type
- Reopening app will open the appropriate screen

## [1.5.0] - 2019-09-14
### Added
- Supports macOS Catalina Apperance Auto (#74)

### Changed
- Update for brightness and connectivity changes are delayed (#73, #57)
- Settings panel will adjust to its smallest size possible.

### Fixed
- Dynamic wallpaper not updating when the "scheduled" option is not enabled

## [1.4.2] - 2019-09-10
### Changed
- Updated Chinese, Japanese, and Russian translations

## [1.4.1] - 2019-09-10
### Added
- Complete Sparkle integration (#6)

## [1.4.0] - 2019-09-08
### Added
- Dynamic wallpaper based on current appearance (#72)

### Fixed
- Automatic appearance switch based on screen brightness works on macOS Mojave 10.14.4 and above (#65, #71)
- Switching apperance won't steal focus from some application and not return it (#70, #62, #18)

## [1.3.0] - 2019-05-17
### Added
- Let's move to `/Applications`

### Fixed
- Crash on launch when not installed to `/Applications` folder by asking them to move (#16, #49)
- Switching theme no longer steal focus from focused application (#62)

### Removed
- The app is no longer restricted within an application sandbox (#63)

## [1.2.0] - 2019-05-07
### Added
- Disable adjust for brightness when scheduled dark mode on
- Quick dark mode toggle in touch bar through `DFRFoundation`
- Update schedule when network status changes

## [1.1.5] - 2019-05-02
### Added
- Partial translations to Japanese and Korean
- Click on notification to create a new issue, or navigates the existing one for known bugs

### Changed
- Updated the program and its dependencies to Swift 5 
- Updated Chinese, Esperanto, and Russian translations
- Using `fatalError` or `debugPrint` instead of `os.log`

### Fixed
- "nil: estimatedNextExecution" should no longer appear (#59)

### Removed
- No more legacy code for supporting macOS 10.13 (never released)

## [1.1.4] - 2019-02-28
### Added
- Nightly builds available at https://rebrand.ly/ddm-nightly
- On Product Hunt at https://www.producthunt.com/posts/dynamic-dark-mode

### Changed
- Now using consistent version number style for artifact and release tag

### Fixed
- Unnecessary scheduling when Mac awakes from sleep

## [1.1.3] - 2019-02-17
### Added
- Prompt for moving to /Applications folder

### Fixed
- Use schedule based dark mode when option turned off
- Ineffective location caching and retrieving
- Control of menu bar icon settings after re-setup

## [1.1.2] - 2018-12-20
### Changed
- Prompt when not authorized to access location

### Fixed
- Memory leaks from re-setup

### Removed
- Unnecessary setup step
- `exit` that was used to pick up automation privacy settings

## [1.1.1] - 2018-12-11
### Fixed
- Inability to get current location (#41)
- Not observing screen brightness changes (#46)

## [1.1.0] - 2018-11-05
### Changed
- Chinese translation of toggle dark mode
- Rename Dynamic to Dynamic Dark Mode

### Fixed
- No scheduled change during sleep

## [1.0.6] - 2018-10-22
### Added
- French translation
- Indonesian translation
- Russian translation
- German translation

### Fixed
- Some parts of the interface elements been cut off

### Removed
- Hope to be included in the Mac App Store

## [1.0.5] - 2018-09-30
### Fixed
- False alarm about `-1751` AppleScript error
- Wrongly turning on dark mode when custom schedule spans within a single day

## [1.0.4] - 2018-09-29
### Added
- Simplfied Chinese Translation

## [1.0.3] - 2018-09-29
### Added
- Installer pkg for download
- Request for location access during setup process
- Button in app's preferences pane to rerun setup process

### Fixed
- Crash on launch (if the app is installed in the `/Applications` folder)

## [1.0.2] - 2018-09-28
### Changed
- Start using non-sandbox-escaping method to control System Events

### Removed
- Request to access `~/Library/Application Scripts/${bundleIdentifier}`

## [1.0.1] - 2018-09-26
### Added
- Ability to switch dark mode when global shortcut key combination is performed
- Ability to toggle dark mode when screen brightness is below/above a set threshold
- Ability to turn on/off dark mode based on a scheduled time
- Ability to automatically set scheduled time as sunset/sunrise based on location
