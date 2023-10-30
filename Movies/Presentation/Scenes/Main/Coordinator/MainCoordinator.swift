//
//  MainCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import SwiftUI

struct MainCoordinator: View {

    private let factory: ScreenFactory
    @StateObject private var state = MainNavigationState()

    init(factory: ScreenFactory) {
        self.factory = factory
    }

    var body: some View {
        NavigationStack(path: $state.navigationPath) {
            MainView(viewModel: .init())
                .navigationDestination(for: MainNavigationState.Screen.self, destination: destination)
        }
    }

    @ViewBuilder
    private func destination(_ screen: MainNavigationState.Screen) -> some View {
        switch screen {
        case .movieDetails(let movie):
            EmptyView()
        }
    }
}
