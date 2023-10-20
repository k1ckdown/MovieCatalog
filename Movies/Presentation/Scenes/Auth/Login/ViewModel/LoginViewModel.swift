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
    
    init() {
        state = .init()
    }
    
    func handle(_ event: LoginViewEvent) {
        switch event {
        case .loginChanged(let login):
            state.login = login
            
        case .passwordChanged(let password):
            state.password = password
        }
    }
}