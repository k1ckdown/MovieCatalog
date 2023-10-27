//
//  ValidateUsernameUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

final class ValidateUsernameUseCase {

    enum UsernameValidationError: LocalizedError {
        case invalidUsername

        var errorDescription: String? {
            Constants.ErrorMessage.invalidUsername
        }
    }

    private enum Constants {
        enum Regex {
            static let username = "[a-zA-Z0-9]+"
            static let formatString = "SELF MATCHES %@"
        }

        enum ErrorMessage {
            static let invalidUsername = "Invalid, can only contain letters or digits"
        }
    }

    func execute(_ username: String) throws {
        let usernamePredicate = NSPredicate(
            format: Constants.Regex.formatString,
            Constants.Regex.username
        )

        guard usernamePredicate.evaluate(with: username) else {
            throw UsernameValidationError.invalidUsername
        }
    }
}
