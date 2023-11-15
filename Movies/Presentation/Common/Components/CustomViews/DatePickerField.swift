//
//  DatePickerField.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct DatePickerField: View {

    @Binding var date: Date

    var body: some View {
        Text(DateFormatter.dateOnly.string(from: date))
            .frame(height: Constants.Label.height)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, Constants.Label.leadingInset)
            .overlay(alignment: .trailing) {
                Image(systemName: Constants.CalendarImage.name)
                    .foregroundStyle(.secondary)
                    .padding(.trailing, Constants.CalendarImage.trailingInset)
                    .overlay {
                        DatePicker("",
                                   selection: $date,
                                   in: ...Date.now,
                                   displayedComponents: .date
                        )
                        .tintColor(.appAccent)
                        .labelsHidden()
                        .datePickerStyle(.compact)
                        .blendMode(.destinationOver)
                        .padding(.leading, Constants.DatePicker.leadingInset)
                    }
                    .clipped()
            }
            .formItemBackground()
    }

    private enum Constants {
        enum Label {
            static let height: CGFloat = 41
            static let leadingInset: CGFloat = 12
        }

        enum CalendarImage {
            static let name = "calendar"
            static let trailingInset: CGFloat = 10
        }

        enum DatePicker {
            static let leadingInset: CGFloat = 77
        }
    }
}
