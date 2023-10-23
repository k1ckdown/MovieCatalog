//
//  CoordinatorFactory.swift
//  Movies
//
//  Created by Ivan Semenov on 22.10.2023.
//

import Foundation

@MainActor
final class CoordinatorFactory {

}

extension CoordinatorFactory {

    func makeWelcomeCoordinator(with navigationState: WelcomeNavigationState) -> WelcomeCoordinator {
        let viewModel = WelcomeViewModel(navigationState: navigationState)
        let coordinator = WelcomeCoordinator(
            state: navigationState,
            welcomeViewModel: viewModel,
            coordinatorFactory: self
        )

        return coordinator
    }

    func makeLoginCoordinator(with navigationState: LoginNavigationState) -> LoginCoordinator {
        let viewModel = LoginViewModel(navigationState: navigationState)
        let coordinator = LoginCoordinator(
            state: navigationState,
            loginViewModel: viewModel,
            coordinatorFactory: self
        )

        return coordinator
    }

}
