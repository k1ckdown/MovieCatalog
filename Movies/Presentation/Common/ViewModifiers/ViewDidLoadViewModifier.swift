//
//  ViewDidLoadViewModifier.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import SwiftUI

struct ViewDidLoadViewModifier: ViewModifier {

    let action: () -> Void
    @State private var didLoad = false

    init(action: @escaping () -> Void) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action()
            }
        }
    }
}

extension View {
    func onLoad(action: @escaping () -> Void) -> some View {
        modifier(ViewDidLoadViewModifier(action: action))
    }
}
