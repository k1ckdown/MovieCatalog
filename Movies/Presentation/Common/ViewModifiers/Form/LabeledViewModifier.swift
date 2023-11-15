//
//  LabeledViewModifier.swift
//  Movies
//
//  Created by Ivan Semenov on 24.10.2023.
//

import SwiftUI

struct LabeledViewModifier: ViewModifier {

    let title: LocalizedStringKey
    let fontSize: CGFloat
    let fontWeight: Font.Weight

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: Constants.contentSpacing) {
            Text(title)
                .font(.system(size: fontSize, weight: fontWeight))
                .foregroundStyle(Color(.label))

            content
        }
    }

    private enum Constants {
        static let contentSpacing: CGFloat = 11
    }
}

extension View {
    func smallLabeled(_ title: LocalizedStringKey) -> some View {
        modifier(
            LabeledViewModifier(title: title, fontSize: 17, fontWeight: .medium)
        )
    }

    func mediumLabeled(_ title: LocalizedStringKey) -> some View {
        modifier(
            LabeledViewModifier(title: title, fontSize: 19, fontWeight: .bold)
        )
    }
}
