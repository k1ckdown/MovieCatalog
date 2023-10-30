//
//  AuthCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 24.10.2023.
//

import SwiftUI

struct AuthCoordinatorView: View {

    private let factory: AuthCoordinatorFactory
    @StateObject private var state = AuthCoordinator()

    init(factory: AuthCoordinatorFactory) {
        self.factory = factory
    }

    var body: some View {
        NavigationStack(path: $state.navigationPath) {
            factory.makeWelcomeView(path: $state.navigationPath)
                .navigationDestination(for: AuthCoordinator.Screen.self, destination: destination)
        }
    }

    @ViewBuilder
    private func destination(_ screen: AuthCoordinator.Screen) -> some View {
        switch screen {
        case .login:
            factory.makeLoginView(path: $state.navigationPath)
        case .personalInfoRegistration:
            factory.makePersonalInfoRegistrationView(path: $state.navigationPath)
        case .passwordRegistration(let personalInfo):
            factory.makePasswordRegistrationView(personalInfo: personalInfo, path: $state.navigationPath)
        }
    }
}

