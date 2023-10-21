//
//  AppNavigationTitleViewModifier.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import SwiftUI

struct AppNavigationTitleViewModifier: ViewModifier {

    init() {
        updateAppearance()
    }

    func body(content: Content) -> some View {
        content
            .navigationTitle(Constants.title)
            .navigationBarTitleDisplayMode(.inline)
    }

    private enum Constants {
        static let title = "FИЛЬМУС"
    }

    private func updateAppearance() {
        let uiColor = UIColor(.appAccent)

        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor]
    }
}

extension View {
    func appNavigationTitle() -> some View {
        modifier(AppNavigationTitleViewModifier())
    }
}
