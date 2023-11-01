//
//  FormTextFieldStyle.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct FormTextFieldStyle: TextFieldStyle {

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(height: Constants.height)
            .padding(.horizontal, Constants.horizontalInset)
            .padding(.vertical, Constants.verticalInset)
    }

    private enum Constants {
        static let height: CGFloat = 37
        static let verticalInset: CGFloat = 2
        static let horizontalInset: CGFloat = 12
    }
}

extension View {
    func formTextFieldStyle() -> some View {
        textFieldStyle(FormTextFieldStyle())
    }
}
