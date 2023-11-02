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
}
