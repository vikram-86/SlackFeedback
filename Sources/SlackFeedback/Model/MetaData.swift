//
//  File.swift
//  
//
//  Created by Vikram on 28/04/2023.
//

import UIKit

internal let OS = "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"
internal let name = UIDevice.modelName

/// Contains meta data for info headers such as osVersion
/// device name and appversion.
/// the **default** value of metadata
/// gets the osVersion and device name automatically
public struct MetaData {
    let osVersion: String
    let deviceName: String
    let appVersion: String?

    init(
        osVersion: String = OS,
        deviceName: String = name,
        appVersion: String? = nil
    ) {
        self.osVersion = osVersion
        self.deviceName = deviceName
        self.appVersion = appVersion
    }

    /// default value gets the osVersion(iOS 16 etc)
    /// and deviceName(iphone 14 Pro) automatically
    public static var `default`: MetaData {
        MetaData()
    }
}
