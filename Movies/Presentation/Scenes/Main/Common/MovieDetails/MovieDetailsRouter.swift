//
//  MovieDetailsRouter.swift
//  Movies
//
//  Created by Ivan Semenov on 09.11.2023.
//

import Foundation

final class MovieDetailsRouter {
    
    private let showAuthSceneHandler: () -> Void
    
    init(showAuthSceneHandler: @escaping () -> Void) {
        self.showAuthSceneHandler = showAuthSceneHandler
    }
}

extension MovieDetailsRouter {
    
    func showAuthScene() {
        showAuthSceneHandler()
    }
}
