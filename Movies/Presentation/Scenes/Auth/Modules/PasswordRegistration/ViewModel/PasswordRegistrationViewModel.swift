//
//  PasswordRegistrationViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

final class PasswordRegistrationViewModel: ViewModel {

    @Published private(set) var state: PasswordRegistrationViewState

    private var personalInfo: PersonalInfoViewModel
    private let router: PasswordRegistrationRouter
    private let registerUserUseCase: RegisterUserUseCase
    private let validatePasswordUseCase: ValidatePasswordUseCase

    init(
        personalInfo: PersonalInfoViewModel,
        router: PasswordRegistrationRouter,
        registerUserUseCase: RegisterUserUseCase,
        validatePasswordUseCase: ValidatePasswordUseCase
    ) {
        self.state = .init()
        self.personalInfo = personalInfo
        self.router = router
        self.registerUserUseCase = registerUserUseCase
        self.validatePasswordUseCase = validatePasswordUseCase
    }

    func handle(_ event: PasswordRegistrationViewEvent) {
        switch event {
        case .onTapLogIn:
            router.showLogin()

        case .onTapRegister:
            registerTapped()

        case .passwordChanged(let password):
            passwordUpdated(password)

        case .confirmPasswordChanged(let password):
            confirmPasswordUpdated(password)
        }
    }
}

private extension PasswordRegistrationViewModel {

    func confirmPasswordUpdated(_ confirmPassword: String) {
        state.confirmPassword = confirmPassword

        if state.password == confirmPassword {
            state.confirmPasswordError = nil
        } else {
            state.confirmPasswordError = LocalizedKeysConstants.ErrorMessage.Password.invalidConfirmPassword
        }
    }

    func passwordUpdated(_ password: String) {
        state.password = password

        if password == state.confirmPassword {
            state.confirmPasswordError = nil
        }

        do {
            try validatePasswordUseCase.execute(password)
            state.passwordError = nil
        } catch {
            state.passwordError = ValidationErrorHandler.message(for: error)
        }
    }

    func registerTapped() {
        let userRegister = UserRegister(
            userName: personalInfo.userName,
            name: personalInfo.name,
            password: state.password,
            email: personalInfo.email,
            birthDate: personalInfo.birthDate.ISO8601Format(),
            gender: personalInfo.gender
        )

        Task {
            do {
                try await registerUserUseCase.execute(userRegister)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
