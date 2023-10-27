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

    var passwordError: String? = ""
    var confirmPasswordError: String? = ""

    var isPasswordErrorShowing: Bool {
        password.isEmpty == false && passwordError != nil
    }

    var isConfirmPasswordErrorShowing: Bool {
        confirmPassword.isEmpty == false && confirmPasswordError != nil
    }

    var isRegisterDisabled: Bool {
        passwordError != nil || confirmPasswordError != nil
    }
}

enum PasswordRegistrationViewEvent {
    case onTapLogIn
    case onTapRegister
    case passwordChanged(String)
    case confirmPasswordChanged(String)
}
