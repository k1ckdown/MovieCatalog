//
//  PersonalInfoRegistrationViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

final class PersonalInfoRegistrationViewModel: ViewModel {

    @Published private(set) var state: PersonalInfoRegistrationViewState

    private let coordinator: AuthCoordinatorProtocol
    private let validateEmailUseCase: ValidateEmailUseCase
    private let validateUsernameUseCase: ValidateUsernameUseCase

    init(
        coordinator: AuthCoordinatorProtocol,
        validateEmailUseCase: ValidateEmailUseCase,
        validateUsernameUseCase: ValidateUsernameUseCase
    ) {
        self.state = .init()
        self.coordinator = coordinator
        self.validateEmailUseCase = validateEmailUseCase
        self.validateUsernameUseCase = validateUsernameUseCase
    }

    func handle(_ event: PersonalInfoRegistrationViewEvent) {
        switch event {
        case .onTapLogIn:
            coordinator.showLogin()

        case .onTapContinue:
            continueTapped()

        case .nameChanged(let name):
            state.name = name

        case .genderChanged(let gender):
            state.gender = gender

        case .usernameChanged(let username):
            usernameUpdated(username)

        case .emailChanged(let email):
            emailUpdated(email)

        case .birthdateChanged(let date):
            state.birthdate = date
        }
    }
}

private extension PersonalInfoRegistrationViewModel {

    func emailUpdated(_ email: String) {
        state.email = email
        do {
            try validateEmailUseCase.execute(email)
            state.emailError = nil
        } catch {
            state.emailError = ValidationErrorHandler.message(for: error)
        }
    }

    func usernameUpdated(_ username: String) {
        state.username = username

        do {
            try validateUsernameUseCase.execute(username)
            state.usernameError = nil
        } catch {
            state.usernameError = ValidationErrorHandler.message(for: error)
        }
    }

    func continueTapped() {
        let personalInfo = PersonalInfoViewModel(
            userName: state.username,
            name: state.name,
            email: state.email,
            birthDate: state.birthdate,
            gender: state.gender
        )

        coordinator.showPasswordRegistration(personalInfo: personalInfo)
    }
}
