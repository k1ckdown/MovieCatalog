//
//  AuthScreenFactory.swift
//  Movies
//
//  Created by Ivan Semenov on 22.10.2023.
//

import Foundation

@MainActor
final class AuthScreenFactory {

    struct Dependencies {
        let validateEmailUseCase: ValidateEmailUseCase
    }

    private let dependencies: Dependencies
    private var registrationViewModel: RegistrationViewModel?

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
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

    func makeRegistrationFirstStageView(router: RegistrationRouter) -> RegistrationFirstStageView {
        let viewModel = makeRegistrationViewModel(router: router)
        let view = RegistrationFirstStageView(viewModel: viewModel)

        return view
    }

    func makeRegistrationSecondStageView(router: RegistrationRouter) -> RegistrationSecondStageView {
        let viewModel = makeRegistrationViewModel(router: router)
        let view = RegistrationSecondStageView(viewModel: viewModel)

        return view
    }

}

private extension AuthScreenFactory {

    func makeRegistrationViewModel(router: RegistrationRouter) -> RegistrationViewModel {
        guard let registrationViewModel else {
            let viewModel = RegistrationViewModel(
                router: router,
                validateEmailUseCase: dependencies.validateEmailUseCase
            )
            self.registrationViewModel = viewModel

            return viewModel
        }

        return registrationViewModel
    }

}
