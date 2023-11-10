//
//  LoginViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import Foundation

final class LoginViewModel: ViewModel {
    
    @Published private(set) var state: LoginViewState
    
    private let coordinator: AuthCoordinatorProtocol
    private let loginUseCase: LoginUseCase
    
    init(coordinator: AuthCoordinatorProtocol, loginUseCase: LoginUseCase) {
        state = .init()
        self.loginUseCase = loginUseCase
        self.coordinator = coordinator
    }
    
    func handle(_ event: LoginViewEvent) {
        switch event {
        case .logInTapped:
            Task { await logInTapped() }

        case .registerTapped:
            coordinator.showPersonalInfoRegistration()
            
        case .usernameChanged(let login):
            state.username = login
            
        case .passwordChanged(let password):
            state.password = password
        }
    }
}

private extension LoginViewModel {
    
    func logInTapped() async {
        state.isLoading = true
        do {
            try await loginUseCase.execute(username: state.username, password: state.password)
            state.loginError = nil
            coordinator.showMainScene()
        } catch {
            state.loginError = LocalizedKeysConstants.ErrorMessage.loginFailed
        }
        state.isLoading = false
    }
}
