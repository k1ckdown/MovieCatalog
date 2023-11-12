//
//  HomeCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class HomeCoordinator: Coordinator {
    
    enum Screen: Routable {
        case movieDetails(String, RatingUpdateHandler)
    }
    
    @Published var navigationPath = [Screen]()
    private let showAuthSceneHandler: () -> Void
    
    init(showAuthSceneHandler: @escaping () -> Void) {
        self.showAuthSceneHandler = showAuthSceneHandler
    }
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    
    func showAuthScene() {
        showAuthSceneHandler()
    }
    
    func showMovieDetails(_ movieId: String, ratingUpdateHandler: RatingUpdateHandler) {
        navigationPath.append(.movieDetails(movieId, ratingUpdateHandler))
    }
}
