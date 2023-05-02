# SlackFeedback Framework

The SlackFeedback Framework is a Swift package that makes it easy for iOS app users to send feedback to a specific Slack channel. It uses Slack's Incoming Webhooks API to send feedback as a message to a designated channel.

## Installation

You can easily install SlackFeedback using Swift Package Manager. Follow these steps to add it to your Xcode project:

1. Open your Xcode project and navigate to File -> Swift Packages -> Add Package Dependency...
2. In the search bar, enter `https://github.com/vikram-86/SlackFeedback`.
3. Select the latest version of the package and click Next.
4. Select the target where you want to use the framework and click Finish.

## Usage

### Set up a Slack Webhook URL

Before you can use SlackFeedback, you need to create a Slack Webhook URL. Follow these steps to create a Webhook URL:

1. Go to your Slack account and navigate to the channel where you want to receive feedback.
2. Click the gear icon next to the channel name and select "Add apps".
3. Search for "Incoming Webhooks" and click "Add to Slack".
4. Follow the instructions to configure the Webhook URL. Make sure to select the channel where you want to receive feedback.

### Import SlackFeedback

In the Swift file where you want to use SlackFeedback, import the package:

`import SlackFeedback`

Configure it with the webhook URL
```swift
let webhookURL = "https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX"
let config = SlackConfiguration(webhook: webhookURL)
let slackFeedback = SlackFeedback(configuration: config)
```

### Send Feedback

To send feedback from your app to Slack, use the `sendFeedback` function:
```swift
let feedback = "I found a bug in the app!"
slackFeedback.sendFeedback(feedback: feedback)
```

## Result in Slack

The result of the feedback sent using SlackFeedback will appear in your designated Slack channel as a message with the following format:
For example:

<img width="463" alt="Skjermbilde 2023-05-02 kl  11 47 51" src="https://user-images.githubusercontent.com/11430094/235636276-f6e9ddff-3847-431c-af98-a8efa031e91c.png">

## Demo App

For a sample implementation of SlackFeedback, check out our demo app. The demo app demonstrates how to use SlackFeedback to send feedback to a Slack channel.

To run the demo app, follow these steps:

1. Clone the repository.
2. Open the `SlackFeedbackDemo.xcodeproj` file in Xcode.
3. Build and run the app on a simulator or device.
4. Enter your Webhook URL and send feedback.

## Contributing

We welcome contributions to the SlackFeedback Framework. To contribute, please follow these steps:

1. Fork the repository and create a new branch for your changes.
2. Make your changes and test them thoroughly.
3. Create a pull request describing your changes.

## License

The SlackFeedback Framework is released under the MIT license. See `LICENSE` for details.
