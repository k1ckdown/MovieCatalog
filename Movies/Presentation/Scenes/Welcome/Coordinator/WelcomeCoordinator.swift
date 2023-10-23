//
//  WelcomeCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

struct WelcomeCoordinator: View {

    @ObservedObject private(set) var state: WelcomeNavigationState

    private let welcomeViewModel: WelcomeViewModel
    private let loginCoordinator: LoginCoordinator

    init(
        state: WelcomeNavigationState,
        welcomeViewModel: WelcomeViewModel,
        coordinatorFactory: CoordinatorFactory
    ) {
        self.state = state
        self.welcomeViewModel = welcomeViewModel
        loginCoordinator = coordinatorFactory.makeLoginCoordinator(with: .init(path: state.$path))
    }

    var body: some View {
        WelcomeView(viewModel: welcomeViewModel)
            .navigationDestination(for: WelcomeNavigationState.Screen.self, destination: coordinator)
    }

    @ViewBuilder
    private func coordinator(for screen: WelcomeNavigationState.Screen) -> some View {
        switch screen {
        case .login:
            loginCoordinator
        case .registration:
            RegistrationFirstStageView(viewModel: RegistrationViewModel())
        }
    }
}
