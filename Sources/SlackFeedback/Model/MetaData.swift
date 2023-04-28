//
//  File.swift
//  
//
//  Created by Vikram on 28/04/2023.
//

import UIKit

internal let OS = "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"
internal let name = UIDevice.modelName

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

    static var `default`: MetaData {
        MetaData()
    }
}
