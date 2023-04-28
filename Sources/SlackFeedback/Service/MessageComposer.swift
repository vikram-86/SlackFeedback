//
//  MessageComposer.swift
//  
//
//  Created by Vikram on 28/04/2023.
//

import Foundation


struct MessageComposer {
    private enum FieldType: String {
        case section
        case mrkdown
        case divider
        case context
    }

    var metaData: MetaData

    init(metaData: MetaData = .default) {
        self.metaData = metaData
    }

    func composeMessage(withFeedback: String, responseEmail: String?, userUUID: String) {

    }
}
