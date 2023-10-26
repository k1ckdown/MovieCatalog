//
//  AuthScreenFactory.swift
//  Movies
//
//  Created by Ivan Semenov on 22.10.2023.
//

import Foundation

@MainActor
final class AuthScreenFactory {
    typealias Factory = ValidateEmailUseCaseFactory

    private let appFactory: Factory

    init(appFactory: Factory) {
        self.appFactory = appFactory
    }
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

    func makePersonalInfoRegistration(router: PersonalInfoRegistrationRouter) -> PersonalInfoRegistrationView {
        let viewModel = PersonalInfoRegistrationViewModel(
            router: router,
            validateEmailUseCase: appFactory.makeValidateEmailUseCase()
        )
        let view = PersonalInfoRegistrationView(viewModel: viewModel)

        return view
    }

    func makePasswordRegistration(router: PasswordRegistrationRouter) -> PasswordRegistrationView {
        let viewModel = PasswordRegistrationViewModel(router: router)
        let view = PasswordRegistrationView(viewModel: viewModel)
        
        return view
    }

}
