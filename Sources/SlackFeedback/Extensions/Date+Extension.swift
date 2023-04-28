//
//  File.swift
//  
//
//  Created by Vikram on 28/04/2023.
//

import Foundation

internal extension Date {
    func formattedDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "nb_NO")
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
}
