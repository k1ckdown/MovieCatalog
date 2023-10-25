//
//  TintColor.swift
//  Movies
//
//  Created by Ivan Semenov on 24.10.2023.
//

import SwiftUI

struct TintColor: ViewModifier {

    let color: Color

    func body(content: Content) -> some View {
        if #available(iOS 16.1, *) {
            content
                .tint(color)
        } else {
            content
                .accentColor(color)
        }
    }
}

extension View {
    func tintColor(_ color: Color) -> some View {
        modifier(TintColor(color: color))
    }
}
