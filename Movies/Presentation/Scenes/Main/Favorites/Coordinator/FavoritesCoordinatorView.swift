//
//  FavoritesCoordinatorView.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import SwiftUI

struct FavoritesCoordinatorView: View {

    private let factory: FavoritesCoordinatorFactory
    @ObservedObject private var coordinator: FavoritesCoordinator

    init(_ coordinator: FavoritesCoordinator, factory: FavoritesCoordinatorFactory) {
        self.factory = factory
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            factory.makeFavoritesView(coordinator: coordinator)
                .navigationDestination(for: FavoritesCoordinator.Screen.self, destination: destination)
        }
    }

    @ViewBuilder
    private func destination(_ screen: FavoritesCoordinator.Screen) -> some View {
        switch screen {
        case .movieDetails(let movieId):
            factory.makeMovieDetailsView(
                movieId: movieId,
                showAuthSceneHandler: { coordinator.showAuthScene() }
            )
        }
    }
}
