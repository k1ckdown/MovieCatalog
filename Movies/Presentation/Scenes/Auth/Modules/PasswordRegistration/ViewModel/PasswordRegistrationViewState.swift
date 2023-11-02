//
//  PasswordRegistrationViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

struct PasswordRegistrationViewState: Equatable {
    var password = ""
    var confirmPassword = ""

    var registerError: String?
    var passwordError: String? = ""
    var confirmPasswordError: String? = ""

    var isLoading = false

    var isRegisterErrorShowing: Bool {
        registerError != nil && isLoading == false
    }
    
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
    case logInTapped
    case registerTapped
    case passwordChanged(String)
    case confirmPasswordChanged(String)
}
