//
//  FormErrorableItemViewModifier.swift
//  Movies
//
//  Created by Ivan Semenov on 27.10.2023.
//

import SwiftUI

struct FormErrorableItemViewModifier: ViewModifier {

    var message: String?
    var isErrorShowed: Bool

    func body(content: Content) -> some View {
        content
            .formTextFieldStyle()
            .formItemBackground(isErrorShowed ? .error : .default)
            .errorFooter(message: message, isShowed: isErrorShowed)
    }
}

extension View {
    func formErrorableItem(
        message: String?,
        isErrorShowed: Bool
    ) -> some View {
        modifier(FormErrorableItemViewModifier(
            message: message,
            isErrorShowed: isErrorShowed
        ))
    }
}
