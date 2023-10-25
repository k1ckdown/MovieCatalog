//
//  BorderedViewModifier.swift
//  Movies
//
//  Created by Ivan Semenov on 20.10.2023.
//

import SwiftUI

struct BorderedViewModifier: ViewModifier {

    let color: Color

    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(color, lineWidth: Constants.borderWidth)
            }
            .padding(Constants.inset)
    }

    private enum Constants {
        static let inset: CGFloat = 1
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 10
    }
}

extension View {
    func bordered(_ color: Color = .appGray) -> some View {
        modifier(BorderedViewModifier(color: color))
    }
}
