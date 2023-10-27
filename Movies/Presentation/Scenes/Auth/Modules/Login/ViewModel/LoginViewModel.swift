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
    private let loginUseCase: LoginUseCase

    init(router: LoginRouter, loginUseCase: LoginUseCase) {
        state = .init()
        self.router = router
        self.loginUseCase = loginUseCase
    }

    func handle(_ event: LoginViewEvent) {
        switch event {
        case .onTapLogIn:
            logInTapped()

        case .onTapRegister:
            router.showRegistration()

        case .usernameChanged(let login):
            state.username = login

        case .passwordChanged(let password):
            state.password = password
        }
    }
}

private extension LoginViewModel {

    func logInTapped() {
        state.isLoading = true
        Task {
            do {
                try await loginUseCase.execute(username: state.username,
                                               password: state.password)
                state.loginError = nil
            } catch {
                state.loginError = LocalizedKeysConstants.ErrorMessage.loginFailed
            }
            state.isLoading = false
        }
    }
}
