//
//  ValidationErrorHandler.swift
//  Movies
//
//  Created by Ivan Semenov on 27.10.2023.
//

import Foundation

enum ValidationErrorHandler {

    static func message(for error: Error) -> String {
        if let passwordError = error as? ValidatePasswordUseCase.PasswordValidationError {
            return passwordMessage(passwordError)
        }

        if let usernameError = error as? ValidateUsernameUseCase.UsernameValidationError {
            return usernameMessage(usernameError)
        }

        if let emailError = error as? ValidateEmailUseCase.EmailValidationError {
            return emailMessage(emailError)
        }

        return LocalizedKey.ErrorMessage.unknownError
    }

    private static func passwordMessage(
        _ error: ValidatePasswordUseCase.PasswordValidationError
    ) -> String {
        switch error {
        case .invalidPassword:
            return LocalizedKey.ErrorMessage.Password.invalidPassword
        }
    }

    private static func usernameMessage(
        _ error: ValidateUsernameUseCase.UsernameValidationError
    ) -> String {
        switch error {
        case .invalidUsername:
            return LocalizedKey.ErrorMessage.invalidUsername
        }
    }

    private static func emailMessage(
        _ error: ValidateEmailUseCase.EmailValidationError
    ) -> String {
        switch error {
        case .invalidUsername:
            return LocalizedKey.ErrorMessage.Email.invalidUsername
        case .missingKeySign:
            return LocalizedKey.ErrorMessage.Email.missingKeySign
        case .invalidDomainPart:
            return LocalizedKey.ErrorMessage.Email.invalidDomainPart
        case .invalidTopLevelDomain:
            return LocalizedKey.ErrorMessage.Email.invalidTopLevelDomain
        }
    }
}
