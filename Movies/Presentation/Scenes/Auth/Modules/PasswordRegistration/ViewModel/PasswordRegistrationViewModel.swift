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

    init(router: PasswordRegistrationRouter) {
        self.state = .init()
        self.router = router
    }

    func handle(_ event: PasswordRegistrationViewEvent) {
        switch event {
        case .onTapLogIn:
            router.showLogin()

        case .onTapRegister:
            break

        case .passwordChanged(let password):
            state.password = password

        case .confirmPasswordChanged(let password):
            state.confirmPassword = password
        }
    }
}
