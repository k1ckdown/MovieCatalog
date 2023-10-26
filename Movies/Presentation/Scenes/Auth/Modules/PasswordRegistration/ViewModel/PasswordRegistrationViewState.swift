//
//  PasswordRegistrationViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

struct PasswordRegistrationViewState: Equatable {
    var password = ""
    var confirmPassword = ""
}

enum PasswordRegistrationViewEvent {
    case onTapLogIn
    case onTapRegister
    case passwordChanged(String)
    case confirmPasswordChanged(String)
}