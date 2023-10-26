//
//  AuthFlow.swift
//  Movies
//
//  Created by Ivan Semenov on 24.10.2023.
//

import SwiftUI

struct AuthFlow: View {

    private let factory: AuthScreenFactory
    @StateObject private var state = AuthFlowState()

    init(factory: AuthScreenFactory) {
        self.factory = factory
    }

    var body: some View {
        NavigationStack(path: $state.navigationPath) {
            rootView
                .navigationDestination(for: AuthFlowState.Screen.self, destination: destination)
        }
    }

    @ViewBuilder
    private var rootView: some View {
        let router = WelcomeRouter(path: $state.navigationPath)
        factory.makeWelcomeView(router: router)
    }

    @ViewBuilder
    private var loginView: LoginView {
        let router = LoginRouter(path: $state.navigationPath)
        factory.makeLoginView(router: router)
    }

    @ViewBuilder
    private var registrationFirstStageView: RegistrationFirstStageView {
        let router = RegistrationRouter(path: $state.navigationPath)
        factory.makeRegistrationFirstStageView(router: router)
    }

    @ViewBuilder
    private var registrationSecondStageView: RegistrationSecondStageView {
        let router = RegistrationRouter(path: $state.navigationPath)
        factory.makeRegistrationSecondStageView(router: router)
    }

    @ViewBuilder
    private func destination(_ screen: AuthFlowState.Screen) -> some View {
        switch screen {
        case .login:
            loginView
        case .registrationFirstStage:
            registrationFirstStageView
        case .registrationSecondStage:
            registrationSecondStageView
        }
    }
}

