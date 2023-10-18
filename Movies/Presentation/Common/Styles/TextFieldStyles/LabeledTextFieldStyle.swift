//
//  LabeledTextFieldStyle.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import SwiftUI

struct LabeledTextFieldStyle: TextFieldStyle {

    let title: LocalizedStringKey

    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
            Text(title)
                .fontWeight(.medium)

            configuration
                .tint(.appAccent)
                .frame(height: Constants.height)
                .padding(.horizontal, Constants.horizontalInset)
                .padding(.vertical, Constants.verticalInset)
                .overlay {
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .stroke(.appGray, lineWidth: Constants.borderWidth)
                }
        }
        .padding(.horizontal)
    }

    private enum Constants {
        static let height: CGFloat = 42
        static let spacing: CGFloat = 12
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 10
        static let verticalInset: CGFloat = 2
        static let horizontalInset: CGFloat = 12
    }
}
