//
//  ProfileCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class ProfileCoordinator: Coordinator {

    enum Screen: Routable {

    }

    @Published var navigationPath = [Screen]()
    private let showAuthSceneHandler: () -> Void

    init(showAuthSceneHandler: @escaping () -> Void) {
        self.showAuthSceneHandler = showAuthSceneHandler
    }
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {

    func showAuthScene() {
        showAuthSceneHandler()
    }
}
