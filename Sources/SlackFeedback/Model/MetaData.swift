//
//  File.swift
//  
//
//  Created by Vikram on 28/04/2023.
//

import UIKit

fileprivate let OS = "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"
fileprivate let name = UIDevice.modelName

struct MetaData {
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
