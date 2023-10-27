//
//  ErrorFooterViewModifier.swift
//  Movies
//
//  Created by Ivan Semenov on 27.10.2023.
//

import SwiftUI

struct ErrorFooterViewModifier: ViewModifier {

    var message: String?
    var isShowed: Bool

    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content

            if isShowed {
                Text(LocalizedStringKey(message ?? ""))
                    .font(.callout)
                    .foregroundStyle(.red)
                    .animation(.bouncy, value: message)
            }
        }
    }
}

extension View {
    func errorFooter(message: String?, isShowed: Bool) -> some View {
        modifier(ErrorFooterViewModifier(message: message, isShowed: isShowed))
    }
}
