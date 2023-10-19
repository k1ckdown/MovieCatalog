//
//  BaseTextFieldStyle.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct BaseTextFieldStyle: TextFieldStyle {

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .tint(.appAccent)
            .frame(height: Constants.height)
            .padding(.horizontal, Constants.horizontalInset)
            .padding(.vertical, Constants.verticalInset)
            .overlay {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(.appGray, lineWidth: Constants.borderWidth)
            }
            .padding(1)
    }

    private enum Constants {
        static let height: CGFloat = 40
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 10
        static let verticalInset: CGFloat = 2
        static let horizontalInset: CGFloat = 12
    }
}
