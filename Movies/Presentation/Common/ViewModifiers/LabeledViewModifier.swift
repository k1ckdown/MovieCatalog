//
//  LabeledViewModifier.swift
//  Movies
//
//  Created by Ivan Semenov on 24.10.2023.
//

import SwiftUI

struct LabeledViewModifier: ViewModifier {

    let title: LocalizedStringKey

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: Constants.contentSpacing) {
            Text(title)
                .font(.system(size: Constants.fontSize, weight: .medium))
                .foregroundStyle(Color(.label))

            content
        }
    }

    private enum Constants {
        static let fontSize: CGFloat = 17
        static let contentSpacing: CGFloat = 11
    }
}

extension View {
    func labeled(_ title: LocalizedStringKey) -> some View {
        modifier(LabeledViewModifier(title: title))
    }
}
