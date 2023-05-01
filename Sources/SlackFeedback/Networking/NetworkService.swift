//
//  NetworkService.swift
//  
//
//  Created by Vikram on 28/04/2023.
//

import Foundation

protocol Networkable {

}

public class NetworkService: Networkable {
    let messageComposer = MessageComposer()

    public init() {}

    public func sendFeedback(_ feedback: String) {
        let message = messageComposer.createSlackMessage(fromFeedback: feedback)
        json(from: message)
    }
}

private extension NetworkService {
    func json(from object: Feedback) {
        do {
            let data = try JSONEncoder().encode(object)
            print(data)
        } catch {
            print(error)
        }
    }
}


