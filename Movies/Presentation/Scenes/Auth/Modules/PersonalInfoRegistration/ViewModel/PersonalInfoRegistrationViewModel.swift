//
//  PersonalInfoRegistrationViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

final class PersonalInfoRegistrationViewModel: ViewModel {

    @Published private(set) var state: PersonalInfoRegistrationViewState

    private let router: PersonalInfoRegistrationRouter
    private let validateEmailUseCase: ValidateEmailUseCase

    init(router: PersonalInfoRegistrationRouter, validateEmailUseCase: ValidateEmailUseCase) {
        self.state = .init()
        self.router = router
        self.validateEmailUseCase = validateEmailUseCase
    }

    func handle(_ event: PersonalInfoRegistrationViewEvent) {
        switch event {
        case .onTapLogIn:
            router.showLogin()

        case .onTapContinue:
            router.showPasswordRegistration()

        case .nameChanged(let name):
            state.name = name

        case .genderChanged(let gender):
            state.gender = gender
            
        case .loginChanged(let login):
            state.login = login

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
        state.isValidEmail = (try? validateEmailUseCase.execute(email)) != nil
    }

}
