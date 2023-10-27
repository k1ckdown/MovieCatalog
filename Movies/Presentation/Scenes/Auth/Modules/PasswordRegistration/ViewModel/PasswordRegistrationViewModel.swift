//
//  PasswordRegistrationViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

final class PasswordRegistrationViewModel: ViewModel {

    @Published private(set) var state: PasswordRegistrationViewState

    private let router: PasswordRegistrationRouter
    private let validatePasswordUseCase: ValidatePasswordUseCase

    init(router: PasswordRegistrationRouter, validatePasswordUseCase: ValidatePasswordUseCase) {
        self.state = .init()
        self.router = router
        self.validatePasswordUseCase = validatePasswordUseCase
    }

    func handle(_ event: PasswordRegistrationViewEvent) {
        switch event {
        case .onTapLogIn:
            router.showLogin()

        case .onTapRegister:
            break

        case .passwordChanged(let password):
            passwordUpdated(password)

        case .confirmPasswordChanged(let password):
            confirmPasswordUpdated(password)
        }
    }
}

private extension PasswordRegistrationViewModel {

    func passwordUpdated(_ password: String) {
        state.password = password

        do {
            try validatePasswordUseCase.execute(password)
            state.passwordError = nil
        } catch {
            state.passwordError = ValidationErrorHandler.message(for: error)
        }
    }

    func confirmPasswordUpdated(_ confirmPassword: String) {
        state.confirmPassword = confirmPassword

        if state.password == confirmPassword {
            state.confirmPasswordError = nil
        } else {
            state.confirmPasswordError = LocalizedKeysConstants.ErrorMessage.Password.invalidConfirmPassword
        }
    }
}
