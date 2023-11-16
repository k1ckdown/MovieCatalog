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

    static let iso8601Full: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        return formatter
    }()

    static let iso8601FullWithMs: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFractionalSeconds, .withFullDate]
        return formatter
    }()
}
