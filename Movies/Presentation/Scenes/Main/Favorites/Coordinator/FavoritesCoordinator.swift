//
//  FavoritesCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class FavoritesCoordinator: Coordinator {

    enum Screen: Routable {
        case movieDetails(MovieDetails)
    }

    @Published var navigationPath = [Screen]()
    private let showAuthSceneHandler: () -> Void

    init(showAuthSceneHandler: @escaping () -> Void) {
        self.showAuthSceneHandler = showAuthSceneHandler
    }
}

extension FavoritesCoordinator: FavoritesCoordinatorProtocol {

    func showAuthScene() {
        showAuthSceneHandler()
    }

    func showMovieDetails(_ movie: MovieDetails) {
        navigationPath.append(.movieDetails(movie))
    }
}
