//
//  ValidateEmailUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

final class ValidateEmailUseCase {

    func execute(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        return emailPredicate.evaluate(with: email)
    }
}
