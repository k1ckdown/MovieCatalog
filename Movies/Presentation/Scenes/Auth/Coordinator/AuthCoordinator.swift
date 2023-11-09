//
//  AuthCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 24.10.2023.
//

import SwiftUI

final class AuthCoordinator: Coordinator {

    enum Screen: Routable {
        case login
        case personalInfoRegistration
        case passwordRegistration(PersonalInfoViewModel)
    }

    @Published var navigationPath = [Screen]()
    private let showMainSceneHandler: () -> Void

    init(showMainSceneHandler: @escaping () -> Void) {
        self.showMainSceneHandler = showMainSceneHandler
    }
}

extension AuthCoordinator: AuthCoordinatorProtocol {

    func showMainScene() {
        showMainSceneHandler()
    }

    func showLogin() {
        updatePathForLogin()
        navigationPath.append(.login)
    }

    func showPersonalInfoRegistration() {
        updatePathForPersonalInfoRegistration()
        navigationPath.append(.personalInfoRegistration)
    }

    func showPasswordRegistration(personalInfo: PersonalInfoViewModel) {
        navigationPath.append(.passwordRegistration(personalInfo))
    }
}

private extension AuthCoordinator {

    func updatePathForPersonalInfoRegistration() {
        if case .login = navigationPath.last {
            navigationPath.removeLast()
        }
    }

    func updatePathForLogin() {
        switch navigationPath.last {
        case .personalInfoRegistration:
            navigationPath.removeLast()

        case .passwordRegistration:
            navigationPath.removeLast()
            navigationPath.removeLast()

        default: break
        }
    }
}
