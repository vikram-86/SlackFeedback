//
//  MessageModels.swift
//
//
//  Created by Vikram on 30/04/2023.
//

import Foundation

/// Represents the different types of elements that can be used in a Slack message.
///
/// This enum provides a set of predefined types that Slack supports. These types can be used
/// to build rich and structured Slack messages.
///
/// - Note: More types may be added in the future as Slack introduces new features.
///
/// Supported types:
/// - **section**: A container for text content.
/// - **mrkdwn**: Markdown-formatted text.
/// - **divider**: A visual divider between message sections.
/// - **context**: A container for contextual information displayed in a compact format.
public enum ElementType: String {
    /// A section block used to organize text or content.
    case section

    /// Markdown-formatted text for displaying rich, styled text.
    case mrkdwn

    /// A divider block to visually separate sections in a message.
    case divider

    /// A context block to display compact, supplementary information.
    case context
}

/// Represents the most basic building block of a Slack message.
///
/// The `Element` structure is used to define text-based content within a Slack message.
/// Elements are typically used inside blocks to create a structured message layout.
///
/// Example usage:
/// ```swift
/// let element = Element(type: ElementType.mrkdwn.rawValue, text: "*Hello, Slack!*")
/// ```
public struct Element: Encodable {
    /// The type of the element, corresponding to `ElementType`.
    public let type: String

    /// The text content of the element.
    public let text: String

    /// Initializes an `Element` with a specific type and text.
    /// - Parameters:
    ///   - type: The type of the element. See `ElementType`.
    ///   - text: The text content to display.
    public init(type: String, text: String) {
        self.type = type
        self.text = text
    }
}

/// Represents a block in a Slack message.
///
/// Blocks are a series of components that can be combined to create visually rich
/// and compellingly interactive messages. Each block contains a `type` field and
/// may include additional elements or text fields.
///
/// Example usage:
/// ```swift
/// let block = Block(type: .section, text: Element(type: "mrkdwn", text: "Hello, Slack!"))
/// ```
public struct Block: Encodable {
    /// The type of the block, corresponding to `ElementType`.
    public let type: String

    /// An optional array of elements contained within the block.
    public let elements: [Element]?

    /// An optional text field for the block, represented as an `Element`.
    public let text: Element?

    /// Initializes a `Block` with specified parameters.
    /// - Parameters:
    ///   - type: The type of the block. See `ElementType`.
    ///   - elements: An optional array of elements to include in the block.
    ///   - text: An optional `Element` for the block's text content.
    public init(type: ElementType, elements: [Element]? = nil, text: Element? = nil) {
        self.type = type.rawValue
        self.elements = elements
        self.text = text
    }
}

/// Represents an attachment in a Slack message.
///
/// Attachments are used to group multiple blocks into a single cohesive unit, allowing for
/// the creation of visually rich and interactive Slack messages.
///
/// Example usage:
/// ```swift
/// let attachment = Attachment(blocks: [Block(type: .divider), Block(type: .section, text: someElement)])
/// ```
public struct Attachment: Encodable {
    /// An array of blocks contained within the attachment.
    public let blocks: [Block]

    /// Initializes an `Attachment` with a specified array of blocks.
    /// - Parameter blocks: An array of `Block` objects to include in the attachment.
    public init(blocks: [Block]) {
        self.blocks = blocks
    }
}

/// Represents the final message to be posted to Slack.
///
/// A `Feedback` object is composed of one or more attachments, each containing a series
/// of blocks that define the structure and content of the message.
///
/// Example usage:
/// ```swift
/// let feedback = Feedback(attachments: [attachment1, attachment2])
/// ```
public struct Feedback: Encodable {
    /// An array of attachments included in the feedback.
    public let attachments: [Attachment]

    /// Initializes a `Feedback` object with specified attachments.
    /// - Parameter attachments: An array of `Attachment` objects to include in the feedback.
    public init(attachments: [Attachment]) {
        self.attachments = attachments
    }
}
