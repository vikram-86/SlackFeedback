//
//  ContentView.swift
//  SlackFeedbackDemo
//
//  Created by Vikram on 30/04/2023.
//

import SwiftUI
import SlackFeedback

struct ContentView: View {
    let slackService = SlackFeedback(configuration: Configuration())
    @State private var feedback = ""

    var body: some View {
        VStack {
            TextField("Enter Feedback", text: $feedback)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button {
                checkAndSendFeedback()
            } label: {
                Text("Send feedback")
            }
            .buttonStyle(.borderedProminent)

        }
        .padding()
    }

    private func checkAndSendFeedback() {
        guard !feedback.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        Task {
            let _ = try? await slackService.sendFeedback(feedback)
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
