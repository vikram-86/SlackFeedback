//
//  MessageComposer.swift
//  
//
//  Created by Vikram on 28/04/2023.
//

import Foundation

// This is ugly.. find a better way
internal typealias Message = [String : [[String : [[String : Any]]]]]

internal struct MessageComposer {
    private typealias Field = [String: String]
    private enum FieldType: String {
        case section
        case mrkdown
        case divider
        case context
    }

    private(set) var metaData: MetaData

    init(metaData: MetaData = .default) {
        self.metaData = metaData
    }

    func composeMessage(
        withFeedback feedback: String,
        responseEmail email: String? = nil,
        userUUID: String? = nil
    ) -> Message {
        var fields = [Field]()
        fields.append(deviceField)
        fields.append(osField)

        if let appVersionField {
            fields.append(appVersionField)
        }

        fields.append(dateField)

        if let userUUID {
            fields.append(createField(withType: .mrkdown, value: userUUID, emoji: ":bust_in_silhouette:"))
        }

        let feedbackField = createField(withMessage: feedback)
        var blocks = [createContext(fields: fields), divider, feedbackField]
        if let email {
            blocks.append(createField(withMessage: email))
        }

        let payload = ["blocks": blocks]
        let attachment = ["attachments": [payload]]
        return attachment
    }
}

//MARK: - Components
private extension MessageComposer {
    private var deviceField: Field {
        createField(withType: .mrkdown, value: metaData.deviceName, emoji: ":iphone:")
    }

    private var osField: Field {
        createField(withType: .mrkdown, value: metaData.osVersion, emoji: ":minidisc:")
    }

    private var dateField: Field {
        createField(withType: .mrkdown, value: Date().formattedDateString(), emoji: ":calendar:")
    }

    private var appVersionField: Field? {
        guard let appVersion = metaData.appVersion else { return nil }
        return createField(withType: .mrkdown, value: appVersion, emoji: ":cd:")
    }

    private var divider: Field {
        ["type": FieldType.divider.rawValue]
    }

    private func createContext(fields: [Field]) -> [String: Any] {
        let infoField: [String: Any] = ["type": FieldType.context.rawValue, "elements": fields]
        let blocks: [String: Any] = ["blocks": [infoField, divider]]
        return blocks
    }
}

// MARK: - Utility
private extension MessageComposer {
    private func createField(withMessage message: String) -> [String: Any] {
        let text = [
            "type": FieldType.mrkdown.rawValue,
            "text": "*\(message)*"
        ]

        return ["type": FieldType.section.rawValue, "text": text]
    }

    private func createField(withType type: FieldType, value: String, emoji: String? = nil ) -> Field {
        let text = emoji != nil ? "*\(emoji!): " : "* "
        return [
            "type": type.rawValue,
            "text": text.appending("\(value)*")
        ]
    }
}
