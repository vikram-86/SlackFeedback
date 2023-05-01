//
//  MessageModels.swift
//  
//
//  Created by Vikram on 30/04/2023.
//

import Foundation

public enum ElementType: String {
    case section
    case mrkdwn
    case divider
    case context
}

public struct Element: Encodable {
    let type: String
    let text: String
}

public struct Block: Encodable {
    let type: String
    let elements: [Element]?
    let text: Element?

    init(type: ElementType, elements: [Element]? = nil, text: Element? = nil) {
        self.type = type.rawValue
        self.elements = elements
        self.text = text
    }
}

public struct Attachment: Encodable {
    let blocks: [Block]
}

public struct Feedback: Encodable {
    let attachments: [Attachment]
}
