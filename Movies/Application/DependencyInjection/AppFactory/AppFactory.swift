//
//  AppFactory.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

final class AppFactory {

}

// MARK: - ValidateEmailUseCaseFactory

extension AppFactory: ValidateEmailUseCaseFactory {
    func makeValidateEmailUseCase() -> ValidateEmailUseCase {
        ValidateEmailUseCase()
    }
}
