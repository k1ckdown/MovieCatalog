//
//  Test.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import SwiftUI

struct AppBackgroundViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            content
        }
    }
}

extension View {
    func appBackground() -> some View {
        modifier(AppBackgroundViewModifier())
    }
}
