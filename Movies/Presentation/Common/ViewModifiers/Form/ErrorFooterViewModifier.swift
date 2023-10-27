//
//  ErrorFooterViewModifier.swift
//  Movies
//
//  Created by Ivan Semenov on 27.10.2023.
//

import SwiftUI

struct ErrorFooterViewModifier: ViewModifier {

    var isShowed: Bool
    var message: String?

    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content

            if isShowed {
                Text(message ?? "")
                    .font(.callout)
                    .foregroundStyle(.red)
                    .animation(.bouncy, value: message)
            }
        }
    }
}

extension View {
    func errorFooter(isShowed: Bool, message: String?) -> some View {
        modifier(ErrorFooterViewModifier(isShowed: isShowed, message: message))
    }
}
