//
//  MessageComposer.swift
//  
//
//  Created by Vikram on 28/04/2023.
//

import Foundation

/// Protocol mainly responsible to compse the message that
/// are to be sent to Slack
/// Uses meta data to compose the info header
public protocol MessageComposable {
    var metaData: MetaData { get }

    /// Composes message according to Slack API
    /// - Parameters:
    ///   - feedback: main message that is to be displayed as a message on slack
    ///   - userID: user id for the user example firebase Id
    ///   - email: user's email so that they can be contacted
    /// - Returns: ``Feedback``
    func createSlackMessage(fromFeedback feedback: String, userID: String?, feedbackMail email: String?) -> Feedback
}

/// Default MessageComposer
public class MessageComposer: MessageComposable {
    public let metaData: MetaData

    public init(metaData: MetaData = .default) {
        self.metaData = metaData
    }
}

public extension MessageComposer {
    /// Composes message according to Slack API
    /// - Parameters:
    ///   - feedback: main message that is to be displayed as a message on slack
    ///   - userID: user id for the user example firebase Id
    ///   - email: user's email so that they can be contacted
    /// - Returns: ``Feedback``
    func createSlackMessage(
        fromFeedback feedback: String,
        userID: String? = nil,
        feedbackMail email: String? = nil
    ) -> Feedback {
        var infoElements = createInfoElementsFromMetaData()

        if let userID {
            infoElements.append(createTextElement(text: userID, withEmoji: ":bust_in_silhouette:"))
        }

        let feedbackElement = createTextElement(text: feedback)
        let message = createSectionBlock(withElement: feedbackElement)
        let infoContext = createContext(withElements: infoElements)
        let divider = createDivider()

        let attachment = createAttachments(withBlocks: [infoContext, divider, message])
        let feedback = Feedback(attachments: [attachment])

        return feedback
    }
}

private extension MessageComposer {
    func createDivider() -> Block {
        return Block(type: .divider)
    }

    func createTextElement(withType type: ElementType = .mrkdwn, text: String, withEmoji emoji: String? = nil) -> Element {
        let message = emoji != nil ? "*\(emoji!)\t" : "*"
        return Element(type: type.rawValue, text: message.appending("\(text)*"))
    }

    func createContext(withElements elements: [Element]) -> Block {
        Block(type: .context, elements: elements)
    }

    func createSectionBlock(withElement element: Element) -> Block {
        Block(type: .section, text: element)
    }

    func createAttachments(withBlocks blocks: [Block]) -> Attachment {
        return Attachment(blocks: blocks)
    }

    func createInfoElementsFromMetaData() -> [Element] {
        let deviceName = createTextElement(text: metaData.deviceName, withEmoji: ":iphone:")
        let osVersion = createTextElement(text: metaData.osVersion, withEmoji: ":minidisc:")
        let dateField = createTextElement(text: Date().formattedDateString(), withEmoji: ":calendar:")
        var blocks = [deviceName, osVersion, dateField]

        if let appVersion = metaData.appVersion {
            blocks.append(createTextElement(text: appVersion, withEmoji: ":cd:"))
        }
        return blocks
    }
}
