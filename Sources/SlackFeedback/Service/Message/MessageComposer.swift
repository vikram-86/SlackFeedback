import Foundation

/// Protocol responsible for composing Slack messages.
/// Uses metadata to compose the informational header.
public protocol MessageComposable {
    var metaData: MetaData { get }

    /// Creates a Slack message.
    /// - Parameters:
    ///   - feedback: The main feedback message.
    ///   - userID: An optional user ID (e.g., Firebase ID).
    ///   - email: An optional email address for contact.
    /// - Returns: A `Feedback` object to be sent.
    func createSlackMessage(
        fromFeedback feedback: String,
        userID: String?,
        feedbackMail email: String?
    ) -> Feedback
}

/// Default implementation of `MessageComposable`.
public class MessageComposer: MessageComposable {
    public let metaData: MetaData

    public init(metaData: MetaData = .default) {
        self.metaData = metaData
    }

    /// Creates a Slack message.
    public func createSlackMessage(
        fromFeedback feedback: String,
        userID: String? = nil,
        feedbackMail email: String? = nil
    ) -> Feedback {
        var infoElements = createInfoElementsFromMetaData()

        if let userID {
            infoElements.append(createTextElement(text: userID, withEmoji: ":bust_in_silhouette:"))
        }

        let feedbackElement = createTextElement(text: feedback)
        let messageBlock = createSectionBlock(withElement: feedbackElement)
        let infoContext = createContext(withElements: infoElements)
        let divider = createDivider()

        let attachment = createAttachments(withBlocks: [infoContext, divider, messageBlock])
        return Feedback(attachments: [attachment])
    }
}

private extension MessageComposer {
    func createDivider() -> Block {
        Block(type: .divider)
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
        Attachment(blocks: blocks)
    }

    func createInfoElementsFromMetaData() -> [Element] {
        let deviceName = createTextElement(text: metaData.deviceName, withEmoji: ":iphone:")
        let osVersion = createTextElement(text: metaData.osVersion, withEmoji: ":minidisc:")
        let dateField = createTextElement(text: Date().formattedDateString(), withEmoji: ":calendar:")
        var elements = [deviceName, osVersion, dateField]

        if let appVersion = metaData.appVersion {
            elements.append(createTextElement(text: appVersion, withEmoji: ":cd:"))
        }
        return elements
    }
}
