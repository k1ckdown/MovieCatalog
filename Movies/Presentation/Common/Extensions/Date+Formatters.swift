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

    private func dateFormatter(for format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }
}
