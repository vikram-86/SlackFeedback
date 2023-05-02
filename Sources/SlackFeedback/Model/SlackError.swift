//
//  SlackError.swift
//  
//
//  Created by Vikram on 02/05/2023.
//

import Foundation

/// Simple Error container for SlackFeedback
public enum SlackError: Error {
    /// Usually thrown when either creating request or composing message fails
    case couldNotCreateMessage
    /// Usually thrown when backend return anything else than **200**
    case couldNotSendMessage
}
