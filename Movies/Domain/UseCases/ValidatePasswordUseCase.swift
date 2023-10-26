//
//  ValidatePasswordUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

final class ValidatePasswordUseCase {

    enum PasswordValidationError: LocalizedError {
        case invalidPassword

        var errorDescription: String? {
            "Must be at least \(Constants.minPasswordLength) characters"
        }
    }

    private enum Constants {
        static let minPasswordLength = 6
    }

    func execute(_ password: String) throws {
        guard password.count >= Constants.minPasswordLength else {
            throw PasswordValidationError.invalidPassword
        }
    }
}
