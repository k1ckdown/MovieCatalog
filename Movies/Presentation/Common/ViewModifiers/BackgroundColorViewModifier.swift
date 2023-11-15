//
//  BackgroundColorViewModifier.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import SwiftUI

struct BackgroundColorViewModifier: ViewModifier {

    let color: Color

    func body(content: Content) -> some View {
        ZStack {
            color
                .ignoresSafeArea()

            content
        }
    }
}

extension View {
    func backgroundColor(_ color: Color = .background) -> some View {
        modifier(BackgroundColorViewModifier(color: color))
    }
}
