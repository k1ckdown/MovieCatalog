//
//  IconDatePickerStyle.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct IconDatePickerStyle: DatePickerStyle {
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: "calendar")
            .imageScale(.large)
            .foregroundStyle(.secondary)
    }
}
