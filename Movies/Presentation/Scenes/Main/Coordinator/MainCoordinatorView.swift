//
//  MainCoordinatorView.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import SwiftUI

struct MainCoordinatorView: View {

    enum Screen: Routable {
        case movieDetails(MovieDetails)
    }

    private let factory: ScreenFactory
    @StateObject private var coordinator = MainCoordinator()

    init(factory: ScreenFactory) {
        self.factory = factory
    }

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            MainView(viewModel: .init(coordinator: coordinator))
                .navigationDestination(for: MainCoordinator.Screen.self, destination: destination)
        }
    }

    @ViewBuilder
    private func destination(_ screen: MainCoordinator.Screen) -> some View {
        switch screen {
        case .movieDetails(let movie):
            EmptyView()
        }
    }
}
