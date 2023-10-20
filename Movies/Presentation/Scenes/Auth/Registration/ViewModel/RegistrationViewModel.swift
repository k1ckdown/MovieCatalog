//
//  RegistrationViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import Foundation

protocol RegistrationViewModelProtocol:
    ViewModel where State == RegistrationViewState, Event == RegistrationViewEvent {}

final class RegistrationViewModel: RegistrationViewModelProtocol {

    @Published private(set) var state: RegistrationViewState

    init() {
        state = .init()
    }

    func handle(_ event: RegistrationViewEvent) {
        switch event {
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
        }
    }
}


