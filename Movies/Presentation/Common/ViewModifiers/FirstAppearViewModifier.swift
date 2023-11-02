//
//  FirstAppearViewModifier.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import SwiftUI

struct FirstAppearViewModifier: ViewModifier {

    let action: () -> Void
    @State private var hasAppeared = false

    init(action: @escaping () -> Void) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            guard hasAppeared == false else { return }

            hasAppeared = true
            action()
        }
    }
}

extension View {
    func firstAppear(action: @escaping () -> Void) -> some View {
        modifier(FirstAppearViewModifier(action: action))
    }
}
