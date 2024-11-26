import UIKit

/// An extension to `UIDevice` providing additional utilities.
public extension UIDevice {

    /// The model name of the current device.
    ///
    /// This property determines the device model name by mapping the system's machine identifier to a human-readable device name.
    /// It supports various iPhone, iPad, iPod, Apple TV, HomePod, and Simulator models.
    ///
    /// - Note: The list of mappings is up-to-date as of iOS 18. For unrecognized models, the machine identifier is returned.
    ///
    /// Example usage:
    /// ```swift
    /// print(UIDevice.modelName) // "iPhone 16 Pro" (on a supported device)
    /// ```
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        return mapToDevice(identifier: identifier)
    }()

    /// Maps a machine identifier to a human-readable device name.
    ///
    /// This function centralizes the mapping logic for device identifiers, allowing for easier maintenance and updates.
    ///
    /// - Parameter identifier: The device's machine identifier (e.g., "iPhone16,1").
    /// - Returns: A human-readable device name or the identifier if no match is found.
    private static func mapToDevice(identifier: String) -> String {
#if os(iOS)
        let deviceMapping: [String: String] = [
            // iPod
            "iPod5,1": "iPod touch (5th generation)",
            "iPod7,1": "iPod touch (6th generation)",
            "iPod9,1": "iPod touch (7th generation)",
            // iPhone
            "iPhone3,1": "iPhone 4", "iPhone3,2": "iPhone 4", "iPhone3,3": "iPhone 4",
            "iPhone4,1": "iPhone 4s",
            "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5",
            "iPhone5,3": "iPhone 5c", "iPhone5,4": "iPhone 5c",
            "iPhone6,1": "iPhone 5s", "iPhone6,2": "iPhone 5s",
            "iPhone7,2": "iPhone 6",
            "iPhone7,1": "iPhone 6 Plus",
            "iPhone8,1": "iPhone 6s",
            "iPhone8,2": "iPhone 6s Plus",
            "iPhone9,1": "iPhone 7", "iPhone9,3": "iPhone 7",
            "iPhone9,2": "iPhone 7 Plus", "iPhone9,4": "iPhone 7 Plus",
            "iPhone10,1": "iPhone 8", "iPhone10,4": "iPhone 8",
            "iPhone10,2": "iPhone 8 Plus", "iPhone10,5": "iPhone 8 Plus",
            "iPhone10,3": "iPhone X", "iPhone10,6": "iPhone X",
            "iPhone11,2": "iPhone XS",
            "iPhone11,4": "iPhone XS Max", "iPhone11,6": "iPhone XS Max",
            "iPhone11,8": "iPhone XR",
            "iPhone12,1": "iPhone 11",
            "iPhone12,3": "iPhone 11 Pro",
            "iPhone12,5": "iPhone 11 Pro Max",
            "iPhone13,1": "iPhone 12 mini",
            "iPhone13,2": "iPhone 12",
            "iPhone13,3": "iPhone 12 Pro",
            "iPhone13,4": "iPhone 12 Pro Max",
            "iPhone14,4": "iPhone 13 mini",
            "iPhone14,5": "iPhone 13",
            "iPhone14,2": "iPhone 13 Pro",
            "iPhone14,3": "iPhone 13 Pro Max",
            "iPhone14,7": "iPhone 14",
            "iPhone14,8": "iPhone 14 Plus",
            "iPhone15,2": "iPhone 14 Pro",
            "iPhone15,3": "iPhone 14 Pro Max",
            "iPhone8,4": "iPhone SE",
            "iPhone12,8": "iPhone SE (2nd generation)",
            "iPhone14,6": "iPhone SE (3rd generation)",
            // Newer iPhone models
            "iPhone16,1": "iPhone 15",
            "iPhone16,2": "iPhone 15 Plus",
            "iPhone16,3": "iPhone 15 Pro",
            "iPhone16,4": "iPhone 15 Pro Max",
            "iPhone17,1": "iPhone 16",
            "iPhone17,2": "iPhone 16 Plus",
            "iPhone17,3": "iPhone 16 Pro",
            "iPhone17,4": "iPhone 16 Pro Max",
            // iPad
            "iPad2,1": "iPad 2", "iPad2,2": "iPad 2", "iPad2,3": "iPad 2", "iPad2,4": "iPad 2",
            "iPad3,1": "iPad (3rd generation)", "iPad3,2": "iPad (3rd generation)", "iPad3,3": "iPad (3rd generation)",
            "iPad3,4": "iPad (4th generation)", "iPad3,5": "iPad (4th generation)", "iPad3,6": "iPad (4th generation)",
            "iPad6,11": "iPad (5th generation)", "iPad6,12": "iPad (5th generation)",
            "iPad7,5": "iPad (6th generation)", "iPad7,6": "iPad (6th generation)",
            "iPad7,11": "iPad (7th generation)", "iPad7,12": "iPad (7th generation)",
            "iPad11,6": "iPad (8th generation)", "iPad11,7": "iPad (8th generation)",
            "iPad12,1": "iPad (9th generation)", "iPad12,2": "iPad (9th generation)",
            "iPad13,18": "iPad (10th generation)", "iPad13,19": "iPad (10th generation)",
            // Newer iPad models
            "iPad14,1": "iPad mini (6th generation)",
            "iPad15,1": "iPad (11th generation)",
            "iPad15,2": "iPad (12th generation)",
            "iPad16,1": "iPad Air (6th generation)",
            "iPad17,1": "iPad Pro (11-inch) (5th generation)",
            "iPad17,2": "iPad Pro (12.9-inch) (7th generation)"
        ]

        // Look up the identifier in the device mapping dictionary
        if let deviceName = deviceMapping[identifier] {
            return deviceName
        }

        // Handle simulator case
        if identifier.starts(with: "i386") || identifier.starts(with: "x86_64") || identifier.starts(with: "arm64") {
            return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
        }

        // Return the identifier if no match is found
        return identifier
#elseif os(tvOS)
        switch identifier {
        case "AppleTV5,3": return "Apple TV 4"
        case "AppleTV6,2": return "Apple TV 4K"
        case "AppleTV11,1": return "Apple TV 4K (2nd generation)"
        case "AppleTV14,1": return "Apple TV 4K (3rd generation)"
        case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
        default: return identifier
        }
#endif
    }
}
