//
//  LoginViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import Foundation

final class LoginViewModel: ViewModel {

    @Published private(set) var state: LoginViewState
    private let router: LoginRouter

    init(router: LoginRouter) {
        state = .init()
        self.router = router
    }

    func handle(_ event: LoginViewEvent) {
        switch event {
        case .onTapLogIn: break

        case .onTapRegister:
            router.showRegistration()

        case .loginChanged(let login):
            state.login = login

        case .passwordChanged(let password):
            state.password = password
        }
    }
}
