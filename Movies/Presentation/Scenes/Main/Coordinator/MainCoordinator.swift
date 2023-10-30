//
//  MainCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class MainCoordinator: Coordinator {

    enum Screen: Routable {
        case movieDetails(MovieDetails)
    }

    @Published var navigationPath = [Screen]()
}

extension MainCoordinator {

    func showMovieDetails(_ movie: MovieDetails) {
        navigationPath.append(.movieDetails(movie))
    }
}
