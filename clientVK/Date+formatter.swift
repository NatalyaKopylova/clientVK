//
//  Date+formatter.swift
//  clientVK
//
//  Created by Natalia on 14.07.2021.
//

import Foundation

extension Date {
    func string(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: self)
    }
}
