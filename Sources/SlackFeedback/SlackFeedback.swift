import Foundation

/// Responsible for sending feedback back to Slack
public struct SlackFeedback {
    private let configuration: SlackConfigurationProtocol

    public init(configuration: SlackConfigurationProtocol) {
        self.configuration = configuration
    }

    /// Converts plain text to Slack format
    /// and sends the feeback to slack using the webhook
    /// provided in ``SlackConfigurationProtocol``
    /// *This function is async, and can throw look at ``SlackError``*
    /// - Parameters:
    ///   - feedback: message to be sent to slack
    ///   - userId: User id of the user sending the feedback, useful if you want to look up in a database
    ///   - email: Email of the user sending the feedback, if they want to be contacted by mail
    public func sendFeedback(
        _ feedback: String,
        userId: String? = nil,
        feedbackEmail email: String? = nil
    ) async throws {
        let feedback = configuration.composeFeedback(feedback)
        guard let request = configuration.createRequestFrom(feedback) else {
            throw SlackError.couldNotCreateMessage
        }

        let (_, response) = try await URLSession.shared.data(for: request)

        guard
            let httpResponse = response as? HTTPURLResponse,
            200..<300 ~= httpResponse.statusCode else {
            throw SlackError.couldNotSendMessage
        }
    }
}
