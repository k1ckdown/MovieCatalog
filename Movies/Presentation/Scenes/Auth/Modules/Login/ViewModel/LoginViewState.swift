//
//  LoginViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import Foundation

struct LoginViewState: Equatable {
    var username = ""
    var password = ""

    var isLoading = false
    var loginError: String?

    var isLogInDisabled: Bool {
        username.isEmpty || password.isEmpty
    }

    var isLoginErrorShowing: Bool {
        loginError != nil && isLoading == false
    }
}

enum LoginViewEvent {
    case logInTapped
    case registerTapped
    case usernameChanged(String)
    case passwordChanged(String)
}
