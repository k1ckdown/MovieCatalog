//
//  LabeledViewModifier.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import SwiftUI

struct LabeledViewModifier: ViewModifier {

    let title: LocalizedStringKey

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
            Text(title)
                .fontWeight(.medium)

            content
        }
        .padding(.horizontal)
    }

    private enum Constants {
        static let spacing: CGFloat = 12
    }
}

extension View {
    func labeled(_ title: LocalizedStringKey) -> some View {
        modifier(LabeledViewModifier(title: title))
    }
}
