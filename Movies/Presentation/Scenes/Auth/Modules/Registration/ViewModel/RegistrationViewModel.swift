//
//  RegistrationViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import Foundation

final class RegistrationViewModel: ViewModel {

    @Published private(set) var state: RegistrationViewState
    private let router: RegistrationRouter

    init(router: RegistrationRouter) {
        self.state = .init()
        self.router = router
    }

    func handle(_ event: RegistrationViewEvent) {
        switch event {
        case .onTapRegister:
            print(state.gender)
        case .onTapLogIn:
            router.showLogin()
        case .onTapContinue:
            router.showSecondStage()
        case .nameChanged(let name):
            state.name = name
        case .genderChanged(let gender):
            state.gender = gender
        case .loginChanged(let login):
            state.login = login
        case .emailChanged(let email):
            state.email = email
        case .birthdateChanged(let date):
            state.birthdate = date
        case .passwordChanged(let password):
            state.password = password
        case .confirmPasswordChanged(let password):
            state.confirmPassword = password
        }
    }
}


