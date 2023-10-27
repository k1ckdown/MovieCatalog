//
//  LocalizedKeysConstants.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

enum LocalizedKeysConstants {
    static let welcomeTitle = LocalizedStringKey("WelcomeTitle")
    static let welcomeBody = LocalizedStringKey("WelcomeBody")
    static let registration = LocalizedStringKey("Registration")
    static let logIn = LocalizedStringKey("LogIn")
    static let entrance = LocalizedStringKey("Entrance")
    static let username = LocalizedStringKey("Username")
    static let password = LocalizedStringKey("Password")
    static let confirmPassword = LocalizedStringKey("ConfirmPassword")
    static let noAccountYet = LocalizedStringKey("NotAccountYet")
    static let register = LocalizedStringKey("Register")
    static let name = LocalizedStringKey("Name")
    static let gender = LocalizedStringKey("Gender")
    static let email = LocalizedStringKey("Email")
    static let birthdate = LocalizedStringKey("Birthdate")
    static let `continue` = LocalizedStringKey("Сontinue")
    static let alreadyHaveAccount = LocalizedStringKey("AlreadyHaveAccount")
    static let logInToAccount = LocalizedStringKey("LogInAccount")
    static let registerAccount = LocalizedStringKey("RegisterAccount")

    enum ErrorMessage {
        static let unknownError = "UnknownError"
        static let invalidUsername = "InvalidUsername"

        enum Password {
            static let invalidPassword = "InvalidPassword"
            static let invalidConfirmPassword = "InvalidConfirmPassword"
        }
        
        enum Email {
            static let invalidUsername = "InvalidEmailUsername"
            static let missingKeySign = "MissingKeySign"
            static let invalidDomainPart = "InvalidDomainPart"
            static let invalidTopLevelDomain = "InvalidTopLevelDomain"
        }
    }
}
