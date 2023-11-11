//
//  LocalizedKey.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

enum LocalizedKey {

    enum ScreenTitle {
        static let home = "Home"
        static let profile = "Profile"
        static let favorites = "Favorites"
    }

    enum Content {
        static let notAvailable = "N/A"
        static let genres = LocalizedStringKey("Genres")
        static let catalog = LocalizedStringKey("Catalog")
        static let reviews = LocalizedStringKey("Reviews")
        static let myReview = LocalizedStringKey("MyReview")
        static let readMore = LocalizedStringKey("ReadMore")
        static let aboutMovie = LocalizedStringKey("AboutMovie")
        static let noFavorites = LocalizedStringKey("NoFavorites")
        static let addFavorites = LocalizedStringKey("AddFavorites")

        enum Action {
            static let edit = LocalizedStringKey("Edit")
            static let deleteReview = LocalizedStringKey("DeleteReview")
        }

        enum Description {
            static let time = "Time"
            static let year = "Year"
            static let fees = "Fees"
            static let budget = "Budget"
            static let country = "Country"
            static let tagline = "Tagline"
            static let director = "Director"
            static let ageLimit = "AgeLimit"
        }
    }

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
            static let logOut = LocalizedStringKey("LogOut")
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
        static let save = LocalizedStringKey("Save")
        static let cancel = LocalizedStringKey("Cancel")
        static let avatarLink = LocalizedStringKey("AvatarLink")
    }

    enum ErrorMessage {
        static let error = "Error"

        static let unknownError = "UnknownError"
        static let invalidUsername = "InvalidUsername"
        static let invalidLink = "InvalidLink"

        static let loginFailed = "LoginFailed"
        static let registrationFailed = "RegistrationFailed"
        static let incorrectLink = "IncorrectLink"

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
