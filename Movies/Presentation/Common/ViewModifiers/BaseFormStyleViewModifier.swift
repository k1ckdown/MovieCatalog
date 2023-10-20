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
            .padding(.horizontal, -3)
            .padding(.top, -35)
    }
}

extension Form {
    func baseFormStyle() -> some View {
        modifier(BaseFormStyleViewModifier())
    }
}
