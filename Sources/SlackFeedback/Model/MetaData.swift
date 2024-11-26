import UIKit

/// Provides metadata for informational headers, such as OS version, device name, and app version.
///
/// The `MetaData` structure allows for automatic population of the operating system version
/// and device name using default values, while also supporting customization.
///
/// Example usage:
/// ```swift
/// let metaData = MetaData.default
/// print(metaData.osVersion) // e.g., "iOS 17.0"
/// print(metaData.deviceName) // e.g., "iPhone 16 Pro"
/// ```
public struct MetaData {

    /// The version of the operating system, e.g., "iOS 17.0".
    public let osVersion: String

    /// The name of the device, e.g., "iPhone 16 Pro".
    public let deviceName: String

    /// The version of the app, if available.
    public let appVersion: String?

    /// Initializes a new instance of `MetaData`.
    ///
    /// - Parameters:
    ///   - osVersion: The operating system version. Defaults to the current device's OS version.
    ///   - deviceName: The name of the device. Defaults to the current device's model name.
    ///   - appVersion: The version of the app. Defaults to `nil`.
    public init(
        osVersion: String = "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)",
        deviceName: String = UIDevice.modelName,
        appVersion: String? = nil
    ) {
        self.osVersion = osVersion
        self.deviceName = deviceName
        self.appVersion = appVersion
    }

    /// The default metadata instance.
    ///
    /// This value automatically populates the operating system version and device name.
    /// Example:
    /// ```swift
    /// let defaultMetaData = MetaData.default
    /// ```
    public static var `default`: MetaData {
        MetaData()
    }
}
