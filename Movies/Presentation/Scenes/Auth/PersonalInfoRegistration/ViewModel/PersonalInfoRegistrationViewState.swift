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
    var username = ""
    var email = ""
    var birthdate = Date.now

    var emailError: String? = ""
    var usernameError: String? = ""

    var isEmailErrorShowing: Bool {
        email.isEmpty == false && emailError != nil
    }

    var isUsernameErrorShowing: Bool {
        username.isEmpty == false && usernameError != nil
    }

    var isContinueDisabled: Bool {
        name.isEmpty || emailError != nil || usernameError != nil
    }
}

enum PersonalInfoRegistrationViewEvent {
    case logInTapped
    case continueTapped
    case nameChanged(String)
    case genderChanged(Gender)
    case usernameChanged(String)
    case emailChanged(String)
    case birthdateChanged(Date)
}
