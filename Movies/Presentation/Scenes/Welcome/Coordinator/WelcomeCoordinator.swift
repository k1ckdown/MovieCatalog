//
//  WelcomeCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

struct WelcomeCoordinator: View {

    @ObservedObject private(set) var state: WelcomeNavigationState

    var body: some View {
        WelcomeView(viewModel: .init(navigationState: state))
            .navigationDestination(for: WelcomeNavigationState.Screen.self) { screen in
                makeCoordinator(for: screen)
            }
    }

    @ViewBuilder
    private func makeCoordinator(for screen: WelcomeNavigationState.Screen) -> some View {
        switch screen {
        case .login:
            LoginView(viewModel: LoginViewModel())
        case .registration:
            RegistrationFirstStageView(viewModel: RegistrationViewModel())
        }
    }
}
