//
//  LoginViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import Foundation

struct LoginViewState: Equatable {
    var login = ""
    var password = ""

    var isDataEmpty: Bool {
        login.isEmpty || password.isEmpty
    }
}

enum LoginViewEvent {
    case onTapRegister
    case loginChanged(String)
    case passwordChanged(String)
}
