//
//  BaseFormStyleViewModifier.swift
//  Movies
//
//  Created by Ivan Semenov on 20.10.2023.
//

import SwiftUI

struct BaseFormStyleViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
            .padding(.top, Constants.topInset)
            .padding(.horizontal, Constants.horizontalInset)
    }

    private enum Constants {
        static let topInset: CGFloat = -35
        static let horizontalInset: CGFloat = -3
    }
}

extension Form {
    func baseFormStyle() -> some View {
        modifier(BaseFormStyleViewModifier())
    }
}
