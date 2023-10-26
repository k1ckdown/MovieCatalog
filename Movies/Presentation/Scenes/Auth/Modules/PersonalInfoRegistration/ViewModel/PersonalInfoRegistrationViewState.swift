//
//  PersonalInfoRegistrationViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

struct PersonalInfoRegistrationViewState: Equatable {
    var name = ""
    var gender = Gender.male
    var login = ""
    var email = ""
    var birthdate = Date.now
    var isValidEmail = false
}

enum PersonalInfoRegistrationViewEvent {
    case onTapContinue
    case onTapLogIn
    case nameChanged(String)
    case genderChanged(Gender)
    case loginChanged(String)
    case emailChanged(String)
    case birthdateChanged(Date)
}
