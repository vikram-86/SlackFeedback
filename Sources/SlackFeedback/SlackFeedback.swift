import Foundation

public struct SlackFeedback {
    private let configuration: Configuration

    public init(configuration: Configuration) {
        self.configuration = configuration
    }


    public func sendFeedback(_ message: String, userId: String? = nil, feedbackEmail email: String? = nil ) async {

        let composedMessage = configuration.messageComposer.createSlackMessage(fromFeedback: message)

        guard let messageData = try? JSONEncoder().encode(composedMessage) else { return }
        guard let url = URL(string: configuration.baseURLString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = messageData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
                print("Status not 200.. something went wrong")
                return
            }

            print("Meessage sent!")
        } catch {
            print(error)
        }
    }
}
