//
//  GrayBorderedViewModifier.swift
//  Movies
//
//  Created by Ivan Semenov on 20.10.2023.
//

import SwiftUI

struct GrayBorderedViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(.appGray, lineWidth: Constants.borderWidth)
            }
            .padding(1)
    }

    private enum Constants {
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 10
    }
}

extension View {
    func grayBordered() -> some View {
        modifier(GrayBorderedViewModifier())
    }
}
