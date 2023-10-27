//
//  ValidateUsernameUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

final class ValidateUsernameUseCase {

    enum UsernameValidationError: Error {
        case invalidUsername
    }

    private enum Constants {
        static let formatString = "SELF MATCHES %@"
        static let regex = "[a-zA-Z0-9]+"
    }

    func execute(_ username: String) throws {
        let usernamePredicate = NSPredicate(
            format: Constants.formatString,
            Constants.regex
        )
        
        guard usernamePredicate.evaluate(with: username) else {
            throw UsernameValidationError.invalidUsername
        }
    }
}
