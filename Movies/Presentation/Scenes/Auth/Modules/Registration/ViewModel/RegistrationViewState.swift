//
//  RegistrationViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import Foundation

struct RegistrationViewState: Equatable {
    var name = ""
    var gender = Gender.male
    var login = ""
    var email = ""
    var birthdate = Date.now
    var password = ""
    var confirmPassword = ""
}

enum RegistrationViewEvent {
    case onTapContinue
    case onTapLogIn
    case onTapRegister
    case nameChanged(String)
    case genderChanged(Gender)
    case loginChanged(String)
    case emailChanged(String)
    case birthdateChanged(Date)
    case passwordChanged(String)
    case confirmPasswordChanged(String)
}
