//
//  LoginViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import Foundation

protocol LoginViewModelProtocol:
    ViewModel where State == LoginViewState, Event == LoginViewEvent {}

final class LoginViewModel: LoginViewModelProtocol {

    @Published private(set) var state: LoginViewState
    private let navigationState: LoginNavigationState

    init(navigationState: LoginNavigationState) {
        state = .init()
        self.navigationState = navigationState
    }

    func handle(_ event: LoginViewEvent) {
        switch event {
        case .onTapRegister:
            navigationState.push(.registration)

        case .loginChanged(let login):
            state.login = login

        case .passwordChanged(let password):
            state.password = password
        }
    }
}
