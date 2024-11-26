import Foundation

/// An error type representing issues encountered while using SlackFeedback.
///
/// The `SlackError` enum defines error cases that can occur during message creation or sending in SlackFeedback.
/// It conforms to the `Error` protocol to allow easy error handling.
///
/// Example usage:
/// ```swift
/// func sendMessage() throws {
///     // Simulate an error
///     throw SlackError.couldNotCreateMessage
/// }
/// ```
public enum SlackError: Error {

    /// Indicates a failure to create a message or request for Slack.
    ///
    /// This error is thrown when the app is unable to compose the message or properly create
    /// the HTTP request required for sending feedback to Slack.
    case couldNotCreateMessage

    /// Indicates a failure to send a message to Slack.
    ///
    /// This error is thrown when the backend returns an unexpected response, such as any
    /// HTTP status code other than **200**.
    case couldNotSendMessage
}
