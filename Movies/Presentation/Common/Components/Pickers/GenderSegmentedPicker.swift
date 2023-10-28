//
//  GenderSegmentedPicker.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import SwiftUI

struct GenderSegmentedPicker: View {

    @Binding var selection: Gender

    var body: some View {
        BaseSegmentedPicker(selection: $selection) {
            ForEach(Gender.allCases) { gender in
                Text(LocalizedStringKey(gender.rawValue)).tag(gender)
            }
        }
        .frame(height: Constants.height)
    }

    private enum Constants {
        static let height: CGFloat = 43
    }
}
