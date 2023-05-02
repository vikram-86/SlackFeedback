//
//  ContentView.swift
//  SlackFeedbackDemo
//
//  Created by Vikram on 30/04/2023.
//

import SwiftUI
import SlackFeedback

struct ContentView: View {

    @State private var feedback = ""
    @State private var webhook = ""

    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Insert Webhook for Slack")
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Webhook", text: $webhook)
                    .textFieldStyle(.roundedBorder)
            }
            Spacer()

            TextField("Enter Feedback", text: $feedback)
                .textFieldStyle(.roundedBorder)

            Button {
                checkAndSendFeedback()
            } label: {
                Text("Send feedback")
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding()
        .padding()
    }

    private func checkAndSendFeedback() {
        guard !webhook.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        guard !feedback.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        let config = SlackConfiguration(webhook: webhook)
        let slackFeedback = SlackFeedback(configuration: config)

        Task {
            do {
                let _ = try await slackFeedback.sendFeedback(feedback)
                print("Message sent")
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

public extension Data {
    var prettyPrintedJSONString: String? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
            let jsonString = String(data: jsonData, encoding: .utf8) else {
                return nil
        }
        return jsonString
    }
}
