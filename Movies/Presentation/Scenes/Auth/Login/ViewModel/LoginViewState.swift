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
}

enum LoginViewEvent {
    case loginChanged(String)
    case passwordChanged(String)
}
