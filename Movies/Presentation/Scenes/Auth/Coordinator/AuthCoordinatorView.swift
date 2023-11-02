//
//  AuthCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 24.10.2023.
//

import SwiftUI

struct AuthCoordinatorView: View {

    private let factory: AuthCoordinatorFactory
    @ObservedObject private var coordinator: AuthCoordinator
    private let personalInfoRegistrationView: PersonalInfoRegistrationView

    init(_ coordinator: AuthCoordinator, factory: AuthCoordinatorFactory) {
        self.factory = factory
        self.coordinator = coordinator
        personalInfoRegistrationView = factory.makePersonalInfoRegistrationView(coordinator: coordinator)
    }

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            factory.makeWelcomeView(coordinator: coordinator)
                .navigationDestination(for: AuthCoordinator.Screen.self, destination: destination)
        }
    }

    @ViewBuilder
    private func destination(_ screen: AuthCoordinator.Screen) -> some View {
        switch screen {
        case .login:
            factory.makeLoginView(coordinator: coordinator)
        case .personalInfoRegistration:
            personalInfoRegistrationView
        case .passwordRegistration(let personalInfo):
            factory.makePasswordRegistrationView(personalInfo: personalInfo, coordinator: coordinator)
        }
    }
}

