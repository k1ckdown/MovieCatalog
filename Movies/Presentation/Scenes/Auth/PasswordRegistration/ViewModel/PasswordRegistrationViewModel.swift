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
    private let coordinator: AuthCoordinatorProtocol
    private let registerUserUseCase: RegisterUserUseCase
    private let validatePasswordUseCase: ValidatePasswordUseCase

    init(
        personalInfo: PersonalInfoViewModel,
        coordinator: AuthCoordinatorProtocol,
        registerUserUseCase: RegisterUserUseCase,
        validatePasswordUseCase: ValidatePasswordUseCase
    ) {
        self.state = .init()
        self.personalInfo = personalInfo
        self.coordinator = coordinator
        self.registerUserUseCase = registerUserUseCase
        self.validatePasswordUseCase = validatePasswordUseCase
    }

    func handle(_ event: PasswordRegistrationViewEvent) {
        switch event {
        case .logInTapped:
            coordinator.showLogin()

        case .registerTapped:
            Task { await registerTapped() }

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
            state.confirmPasswordError = LocalizedKey.ErrorMessage.Password.invalidConfirmPassword
        }
    }

    func passwordUpdated(_ password: String) {
        state.password = password

        if password == state.confirmPassword,
           state.confirmPassword.isEmpty == false {
            state.confirmPasswordError = nil
        }

        do {
            try validatePasswordUseCase.execute(password)
            state.passwordError = nil
        } catch {
            state.passwordError = ValidationErrorHandler.message(for: error)
        }
    }

    func registerTapped() async {
        let userRegister = UserRegister(
            userName: personalInfo.userName,
            name: personalInfo.name,
            password: state.password,
            email: personalInfo.email,
            birthDate: personalInfo.birthDate.ISO8601Format(),
            gender: personalInfo.gender
        )

        state.isLoading = true
        do {
            try await registerUserUseCase.execute(userRegister)
            state.registerError = nil
            coordinator.showMainScene()
        } catch {
            state.registerError = LocalizedKey.ErrorMessage.registrationFailed
        }
        state.isLoading = false
    }
}
