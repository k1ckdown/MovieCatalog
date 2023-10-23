//
//  LoginCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 22.10.2023.
//

import SwiftUI

struct LoginCoordinator: View {

    @ObservedObject private(set) var state: LoginNavigationState

    private let loginViewModel: LoginViewModel

    init(
        state: LoginNavigationState,
        loginViewModel: LoginViewModel,
        coordinatorFactory: CoordinatorFactory
    ) {
        self.state = state
        self.loginViewModel = loginViewModel
    }

    var body: some View {
        LoginView(viewModel: loginViewModel)
            .navigationDestination(for: LoginNavigationState.Screen.self, destination: coordinator)
    }

    @ViewBuilder
    func coordinator(for screen: LoginNavigationState.Screen) -> some View {
        switch screen {
        case .registration:
            EmptyView()
        }
    }
}
