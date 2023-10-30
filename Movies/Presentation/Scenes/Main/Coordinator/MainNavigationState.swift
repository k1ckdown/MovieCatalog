//
//  MainNavigationState.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class MainNavigationState: NavigationState {

    enum Screen: Routable {
        case movieDetails(MovieDetails)
    }

    @Published var navigationPath = [Screen]()
}
