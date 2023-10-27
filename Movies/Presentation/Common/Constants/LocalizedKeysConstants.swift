//
//  LocalizedKeysConstants.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

enum LocalizedKeysConstants {

    enum Welcome {
        static let title = LocalizedStringKey("WelcomeTitle")
        static let body = LocalizedStringKey("WelcomeBody")
    }

    enum Auth {
        enum Label {
            static let entrance = LocalizedStringKey("Entrance")
            static let registration = LocalizedStringKey("Registration")
        }

        enum Action {
            static let logIn = LocalizedStringKey("LogIn")
            static let register = LocalizedStringKey("Register")
            static let `continue` = LocalizedStringKey("Сontinue")
        }

        enum Callout {
            static let noAccountYet = LocalizedStringKey("NotAccountYet")
            static let registerAccount = LocalizedStringKey("RegisterAccount")

            static let alreadyHaveAccount = LocalizedStringKey("AlreadyHaveAccount")
            static let logInToAccount = LocalizedStringKey("LogInAccount")
        }
    }

    enum Profile {
        static let username = LocalizedStringKey("Username")
        static let name = LocalizedStringKey("Name")
        static let gender = LocalizedStringKey("Gender")
        static let email = LocalizedStringKey("Email")
        static let birthdate = LocalizedStringKey("Birthdate")
        static let password = LocalizedStringKey("Password")
        static let confirmPassword = LocalizedStringKey("ConfirmPassword")
    }

    enum ErrorMessage {
        static let unknownError = "UnknownError"
        static let invalidUsername = "InvalidUsername"

        static let loginFailed = "LoginFailed"
        static let registrationFailed = "RegistrationFailed"

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
