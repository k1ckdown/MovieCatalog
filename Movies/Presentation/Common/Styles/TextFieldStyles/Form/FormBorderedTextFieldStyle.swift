//
//  FormBorderedTextFieldStyle.swift
//  Movies
//
//  Created by Ivan Semenov on 27.10.2023.
//

import SwiftUI

struct FormBorderedTextFieldStyle: TextFieldStyle {

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .formTextFieldStyle()
            .formItemBackground()
    }
}

extension View {
    func formBorderedTextFieldStyle() -> some View {
        textFieldStyle(FormBorderedTextFieldStyle())
    }
}
