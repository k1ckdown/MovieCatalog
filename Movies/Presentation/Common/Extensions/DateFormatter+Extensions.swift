//
//  DateFormatter+Extensions.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

extension DateFormatter {

    static func string(iso string: String) -> String {
        let date = DateFormatter.iso8601Full.date(from: string) ?? .now
        return DateFormatter.dateOnly.string(from: date)
    }

    static let dateOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }()

    static let iso8601FullWithMs: DateFormatter = {
        let formatter = iso8601Full
        formatter.dateFormat += ".SSSSSSS"
        return formatter
    }()

    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
