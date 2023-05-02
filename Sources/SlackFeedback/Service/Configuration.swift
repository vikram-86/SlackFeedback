//
//  Configuration.swift
//  
//
//  Created by Vikram on 01/05/2023.
//

import Foundation

public protocol SlackConfigurationProtocol {
    var webhook: String { get }
    var composer: MessageComposable { get }
}

internal extension SlackConfigurationProtocol {
    func composeFeedback(
        _ message: String,
        userId: String? = nil,
        feebackEmail email: String? = nil
    ) -> Feedback {
        composer.createSlackMessage(
            fromFeedback: message,
            userID: userId,
            feedbackMail: email
        )
    }

    func createRequestFrom(_ feedback: Feedback) -> URLRequest? {
        guard let url = URL(string: webhook) else { return nil }
        guard let payload = try? JSONEncoder().encode(feedback) else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = payload

        return request
    }
}


/// Default Slack Configuration
public struct SlackConfiguration: SlackConfigurationProtocol {
    
    public var webhook: String
    public var composer: MessageComposable

    public init(webhook: String, composer: MessageComposable = MessageComposer()) {
        self.webhook = webhook
        self.composer = composer
    }
}
