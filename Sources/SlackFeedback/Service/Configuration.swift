import Foundation

/// Protocol defining the configuration for Slack integration.
public protocol SlackConfigurationProtocol {
    /// The Slack webhook URL used to send messages.
    var webhook: String { get }
    /// The composer responsible for creating Slack messages.
    var composer: MessageComposable { get }
}

internal extension SlackConfigurationProtocol {
    /// Composes feedback to send to Slack.
    /// - Parameters:
    ///   - message: The feedback message.
    ///   - userId: An optional user ID (e.g., Firebase ID).
    ///   - email: An optional email address for contact.
    /// - Returns: A `Feedback` object ready to be sent.
    func composeFeedback(
        _ message: String,
        userId: String? = nil,
        feedbackEmail email: String? = nil
    ) -> Feedback {
        composer.createSlackMessage(
            fromFeedback: message,
            userID: userId,
            feedbackMail: email
        )
    }

    /// Creates a `URLRequest` for sending a `Feedback` object to Slack.
    /// - Parameter feedback: The feedback message to send.
    /// - Returns: An optional `URLRequest` if the encoding and URL are valid.
    func createRequest(from feedback: Feedback) -> URLRequest? {
        guard let url = URL(string: webhook) else { return nil }
        guard let payload = try? JSONEncoder().encode(feedback) else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = payload

        return request
    }

    /// Sends feedback to Slack asynchronously.
    /// - Parameters:
    ///   - feedback: The `Feedback` object to send.
    /// - Returns: A boolean indicating whether the operation succeeded.
    func sendFeedback(_ feedback: Feedback) async throws -> Bool {
        guard let request = createRequest(from: feedback) else {
            throw SlackError.couldNotCreateMessage
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw SlackError.couldNotSendMessage
        }

        return true
    }
}

/// Default implementation of `SlackConfiguration`.
public struct SlackConfiguration: SlackConfigurationProtocol {
    public let webhook: String
    public let composer: MessageComposable

    /// Initializes a new `SlackConfiguration`.
    /// - Parameters:
    ///   - webhook: The Slack webhook URL.
    ///   - composer: An optional `MessageComposable` instance. Defaults to `MessageComposer`.
    public init(webhook: String, composer: MessageComposable = MessageComposer()) {
        self.webhook = webhook
        self.composer = composer
    }
}
