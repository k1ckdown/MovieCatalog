//
//  ValidateEmailUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

final class ValidateEmailUseCase {

    enum EmailValidationError: LocalizedError {
        case invalidUsername
        case missingKeySign
        case invalidDomainPart
        case invalidTopLevelDomain

        var errorDescription: String? {
            switch self {
            case .invalidUsername:
                return Constants.ErrorMessage.invalidUsername
            case .missingKeySign:
                return Constants.ErrorMessage.missingKeySign
            case .invalidDomainPart:
                return Constants.ErrorMessage.invalidDomainPart
            case .invalidTopLevelDomain:
                return Constants.ErrorMessage.invalidTopLevelDomain
            }
        }
    }

    func execute(_ email: String) throws {
        guard isValidUsername(email) else {
            throw EmailValidationError.invalidUsername
        }

        guard isContainsKeySign(email) else {
            throw EmailValidationError.missingKeySign
        }

        guard isValidDomainPart(email) else {
            throw EmailValidationError.invalidDomainPart
        }

        guard isValidTopLevelDomain(email) else {
            throw EmailValidationError.invalidTopLevelDomain
        }
    }
}

private extension ValidateEmailUseCase {

    enum Constants {
        enum Regex {
            static let formatString = "SELF MATCHES %@"
            static let usernamePart = "[A-Z0-9a-z._%+-]+"
            static let domainPart = "[A-Za-z0-9.-]+"
            static let topLevelDomain = "^[A-Za-z]{2,64}"
        }

        enum ErrorMessage {
            static let invalidUsername = "Invalid username"
            static let missingKeySign = "Missing @ sign"
            static let invalidDomainPart = "Invalid domain part"
            static let invalidTopLevelDomain = "Invalid top-level domain"
        }
    }

    func isContainsKeySign(_ email: String) -> Bool {
        email.contains("@")
    }

    func getEmailUsernamePart(_ email: String) -> String {
        email.components(separatedBy: "@").first ?? ""
    }

    func getEmailTopLevelDomain(_ email: String) -> String {
        email.components(separatedBy: ".").last ?? ""
    }

    func getEmailDomainPart(_ email: String) -> String {
        guard let index = email.firstIndex(of: "@") else { return "" }
        let substring = email[email.index(after: index)...]

        return substring.components(separatedBy: ".").first ?? ""
    }

    func isValidUsername(_ email: String) -> Bool {
        let usernamePartPredicate = NSPredicate(
            format: Constants.Regex.formatString,
            Constants.Regex.usernamePart
        )

        return usernamePartPredicate.evaluate(with: getEmailUsernamePart(email))
    }

    func isValidDomainPart(_ email: String) -> Bool {
        let domainPartPredicate = NSPredicate(
            format: Constants.Regex.formatString,
            Constants.Regex.domainPart
        )

        return domainPartPredicate.evaluate(with: getEmailDomainPart(email))
    }

    func isValidTopLevelDomain(_ email: String) -> Bool {
        let topLevelDomainPredicate = NSPredicate(
            format: Constants.Regex.formatString,
            Constants.Regex.topLevelDomain
        )

        return topLevelDomainPredicate.evaluate(with: getEmailTopLevelDomain(email))
    }
}
