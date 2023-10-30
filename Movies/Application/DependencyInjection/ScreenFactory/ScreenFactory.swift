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

extension ScreenFactory: MainViewFactory {
    func makeMainView(coordinator: MainCoordinator) -> MainView {
        let viewModel = MainViewModel(coordinator: coordinator)
        let view = MainView(viewModel: viewModel)

        return view
    }
}

// MARK: - WelcomeViewFactory

extension ScreenFactory: WelcomeViewFactory {
    func makeWelcomeView(coordinator: AuthCoordinatorProtocol) -> WelcomeView {
        let viewModel = WelcomeViewModel(coordinator: coordinator)
        let view = WelcomeView(viewModel: viewModel)

        return view
    }
}

// MARK: - LoginViewFactory

extension ScreenFactory: LoginViewFactory {
    func makeLoginView(coordinator: AuthCoordinatorProtocol) -> LoginView {
        let viewModel = LoginViewModel(
            coordinator: coordinator,
            loginUseCase: appFactory.makeLoginUseCase()
        )
        let view = LoginView(viewModel: viewModel)

        return view
    }
}

// MARK: - PersonalInfoRegistrationViewFactory

extension ScreenFactory: PersonalInfoRegistrationViewFactory {
    func makePersonalInfoRegistrationView(
        coordinator: AuthCoordinatorProtocol
    ) -> PersonalInfoRegistrationView {
        let viewModel = PersonalInfoRegistrationViewModel(
            coordinator: coordinator,
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
        coordinator: AuthCoordinatorProtocol
    ) -> PasswordRegistrationView {
        let viewModel = PasswordRegistrationViewModel(
            personalInfo: personalInfo,
            coordinator: coordinator,
            registerUserUseCase: appFactory.makeRegisterUserUseCase(),
            validatePasswordUseCase: appFactory.makeValidatePasswordUseCase()
        )
        let view = PasswordRegistrationView(viewModel: viewModel)

        return view
    }
}
