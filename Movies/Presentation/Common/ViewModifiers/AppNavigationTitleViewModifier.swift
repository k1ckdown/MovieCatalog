//
//  AppNavigationTitleViewModifier.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import SwiftUI

struct AppNavigationTitleViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .navigationTitle(Constants.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
            .onAppear {
                setupNavigationBar(.appAccent)
            }
            .onDisappear {
                setupNavigationBar(.label)
            }
    }

    private enum Constants {
        static let title = "FИЛЬМУС"
    }

    @MainActor private func setupNavigationBar(_ color: UIColor) {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: color]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: color]
    }
}

extension View {
    func appNavigationTitle() -> some View {
        modifier(AppNavigationTitleViewModifier())
    }
}
