//
//  MessageModels.swift
//  
//
//  Created by Vikram on 30/04/2023.
//

import Foundation

/// Different element types for the Slack message
/// More will be added in the future
/// currently these types are supported
/// **section, markdown, divider and context**
public enum ElementType: String {
    case section
    case mrkdwn
    case divider
    case context
}


/// Most basic building block of the slack message
public struct Element: Encodable {
    /// type refers to ``ElementType``
    public let type: String
    public let text: String
}


/// Every block contains a type field — specifying which of the available blocks to use — along with other fields that describe the content of the block. see ``ElementType``
/// Individual blocks can be stacked together to create complex visual layouts.
/// Blocks are a series of components that can be combined to create visually rich and compellingly interactive messages.
public struct Block: Encodable {
    public let type: String
    public let elements: [Element]?
    public let text: Element?

    init(type: ElementType, elements: [Element]? = nil, text: Element? = nil) {
        self.type = type.rawValue
        self.elements = elements
        self.text = text
    }
}


/// Attachment contains a list of ``Block`` to create
/// a create a visually rich and compelling interactive messages.
public struct Attachment: Encodable {
    public let blocks: [Block]
}


/// Feedback is a the final message to be posted to Slack.
/// It contains a series of ``Attachment`` to create a visually compelling message
public struct Feedback: Encodable {
    public let attachments: [Attachment]
}
