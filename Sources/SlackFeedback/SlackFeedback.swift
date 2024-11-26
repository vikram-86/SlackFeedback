import Foundation

/// A service responsible for sending feedback to Slack.
///
/// `SlackFeedback` provides functionality to convert plain text feedback into Slack-compatible
/// messages and send them via a webhook. It utilizes the configuration provided by a `SlackConfigurationProtocol`
/// to manage message composition and HTTP requests.
///
/// Example usage:
/// ```swift
/// let configuration = SlackConfiguration(webhook: "<YOUR_WEBHOOK_URL>")
/// let slackFeedback = SlackFeedback(configuration: configuration)
///
/// Task {
///     do {
///         try await slackFeedback.sendFeedback("This is a test feedback!", userId: "12345", feedbackEmail: "test@example.com")
///         print("Feedback sent successfully!")
///     } catch {
///         print("Failed to send feedback: \(error)")
///     }
/// }
/// ```
public struct SlackFeedback {
    /// The configuration used for Slack message composition and sending.
    private let configuration: SlackConfigurationProtocol

    /// Initializes a new instance of `SlackFeedback`.
    ///
    /// - Parameter configuration: The configuration protocol implementation used to manage
    ///   webhook, message composition, and request creation.
    public init(configuration: SlackConfigurationProtocol) {
        self.configuration = configuration
    }

    /// Sends feedback to Slack using the webhook specified in the configuration.
    ///
    /// This function asynchronously sends the provided feedback message to Slack.
    /// The feedback is composed into a Slack-compatible format using `SlackConfigurationProtocol`.
    ///
    /// - Parameters:
    ///   - feedback: The plain text feedback message to send to Slack.
    ///   - userId: An optional user ID of the sender, useful for tracking purposes (e.g., Firebase ID).
    ///   - email: An optional email address of the sender, useful for follow-up communication.
    ///
    /// - Throws:
    ///   - `SlackError.couldNotCreateMessage`: If the feedback message or request could not be created.
    ///   - `SlackError.couldNotSendMessage`: If the HTTP response indicates a failure.
    ///
    /// - Note: This function uses `async/await` for asynchronous execution.
    public func sendFeedback(
        _ feedback: String,
        userId: String? = nil,
        feedbackEmail email: String? = nil
    ) async throws {
        // Compose the feedback into a Slack-compatible message.
        let feedback = configuration.composeFeedback(feedback, userId: userId, feedbackEmail: email)

        // Create a URLRequest from the feedback.
        guard let request = configuration.createRequest(from: feedback) else {
            throw SlackError.couldNotCreateMessage
        }

        // Perform the HTTP request to send the feedback.
        let (_, response) = try await URLSession.shared.data(for: request)

        // Validate the HTTP response.
        guard
            let httpResponse = response as? HTTPURLResponse,
            200..<300 ~= httpResponse.statusCode else {
            throw SlackError.couldNotSendMessage
        }
    }
}
