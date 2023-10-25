//
//  AuthScreenFactory.swift
//  Movies
//
//  Created by Ivan Semenov on 22.10.2023.
//

import Foundation

@MainActor
final class AuthScreenFactory {
    private var registrationViewModel: RegistrationViewModel?
}

extension AuthScreenFactory {

    func makeWelcomeView(router: WelcomeRouter) -> WelcomeView {
        let viewModel = WelcomeViewModel(router: router)
        let view = WelcomeView(viewModel: viewModel)

        return view
    }

    func makeLoginView(router: LoginRouter) -> LoginView {
        let viewModel = LoginViewModel(router: router)
        let view = LoginView(viewModel: viewModel)

        return view
    }

    func makeRegistrationFirstStageView(router: RegistrationRouter) -> RegistrationFirstStageView {
        let registrationViewModel = registrationViewModel ?? .init(router: router)
        let view = RegistrationFirstStageView(viewModel: registrationViewModel)
        self.registrationViewModel = registrationViewModel

        return view
    }

    func makeRegistrationSecondStageView(router: RegistrationRouter) -> RegistrationSecondStageView {
        let viewModel = registrationViewModel ?? .init(router: router)
        let view = RegistrationSecondStageView(viewModel: viewModel)

        return view
    }

}
