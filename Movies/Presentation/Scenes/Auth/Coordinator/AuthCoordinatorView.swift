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
//        self.personalInfoRegistrationView = factory.makePersonalInfoRegistrationView(с)
    }

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            factory.makeWelcomeView(path: $coordinator.navigationPath)
                .navigationDestination(for: AuthCoordinator.Screen.self, destination: destination)
        }
    }

    @ViewBuilder
    private func destination(_ screen: AuthCoordinator.Screen) -> some View {
        switch screen {
        case .login:
            factory.makeLoginView(path: $coordinator.navigationPath)
        case .personalInfoRegistration:
            factory.makePersonalInfoRegistrationView(path: $coordinator.navigationPath)
        case .passwordRegistration(let personalInfo):
            factory.makePasswordRegistrationView(personalInfo: personalInfo, path: $coordinator.navigationPath)
        }
    }
}

