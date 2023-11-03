//
//  FormBorderedTextFieldStyle.swift
//  Movies
//
//  Created by Ivan Semenov on 27.10.2023.
//

import SwiftUI

struct FormBorderedTextFieldStyle: TextFieldStyle {

    let style: FormItemBackgroundViewModifier.Style

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .formTextFieldStyle()
            .formItemBackground(style)
    }
}

extension View {
    func formBorderedTextFieldStyle(
        style: FormItemBackgroundViewModifier.Style = .default
    ) -> some View {
        textFieldStyle(FormBorderedTextFieldStyle(style: style))
    }
}
