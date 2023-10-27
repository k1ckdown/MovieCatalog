//
//  ScreenFactory.swift
//  Movies
//
//  Created by Ivan Semenov on 22.10.2023.
//

import SwiftUI

@MainActor
final class ScreenFactory: AuthCoordinatorFactory {

    private let appFactory: AppFactory

    init(appFactory: AppFactory) {
        self.appFactory = appFactory
    }
}

// MARK: - WelcomeViewFactory

extension ScreenFactory: WelcomeViewFactory {
    func makeWelcomeView(path: Binding<AuthNavigationPath>) -> WelcomeView {
        let router = WelcomeRouter(path: path)
        let viewModel = WelcomeViewModel(router: router)
        let view = WelcomeView(viewModel: viewModel)

        return view
    }
}

// MARK: - LoginViewFactory

extension ScreenFactory: LoginViewFactory {
    func makeLoginView(path: Binding<AuthNavigationPath>) -> LoginView {
        let router = LoginRouter(path: path)
        let viewModel = LoginViewModel(router: router, loginUseCase: appFactory.makeLoginUseCase())
        let view = LoginView(viewModel: viewModel)

        return view
    }
}

// MARK: - PersonalInfoRegistrationViewFactory

extension ScreenFactory: PersonalInfoRegistrationViewFactory {
    func makePersonalInfoRegistrationView(
        path: Binding<AuthNavigationPath>
    ) -> PersonalInfoRegistrationView {
        let router = PersonalInfoRegistrationRouter(path: path)
        let viewModel = PersonalInfoRegistrationViewModel(
            router: router,
            validateEmailUseCase: appFactory.makeValidateEmailUseCase(),
            validateUsernameUseCase: appFactory.makeValidateUsernameUseCase()
        )
        let view = PersonalInfoRegistrationView(viewModel: viewModel)

        return view
    }
}

// MARK: - PasswordRegistrationViewFactory

extension ScreenFactory: PasswordRegistrationViewFactory {
    func makePasswordRegistrationView(
        personalInfo: PersonalInfoViewModel,
        path: Binding<AuthNavigationPath>
    ) -> PasswordRegistrationView {
        let router = PasswordRegistrationRouter(path: path)
        let viewModel = PasswordRegistrationViewModel(
            personalInfo: personalInfo,
            router: router,
            registerUserUseCase: appFactory.makeRegisterUserUseCase(),
            validatePasswordUseCase: appFactory.makeValidatePasswordUseCase()
        )
        let view = PasswordRegistrationView(viewModel: viewModel)

        return view
    }
}
