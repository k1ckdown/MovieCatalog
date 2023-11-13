//
//  Date+Formatters.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

extension Date {

    func formatToDateMonthYear() -> String {
        let dateFormatter = dateFormatter(for: "dd.MM.yy")
        return dateFormatter.string(from: self)
    }

    func convertFromServer(_ dateString: String) -> Date {
        let dateFormatter = dateFormatter(for: "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: dateString) ?? .now
    }

    private func dateFormatter(for format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }
}
