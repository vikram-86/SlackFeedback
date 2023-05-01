//
//  MessageComposer.swift
//  
//
//  Created by Vikram on 28/04/2023.
//

import Foundation

public protocol MessageComposable {
    func setMetaData(_ metaData: MetaData)
    func createSlackMessage(fromFeedback feedback: String, userID: String?, feedbackMail email: String?) -> Feedback
}

public class MessageComposer: MessageComposable {
    private(set) var metaData: MetaData

    public init() {
        self.metaData = .default
    }
}

public extension MessageComposer {
    func setMetaData(_ metaData: MetaData) {
        self.metaData = metaData
    }

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
