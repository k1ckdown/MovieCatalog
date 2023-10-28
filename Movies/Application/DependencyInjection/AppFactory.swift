//
//  AppFactory.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

final class AppFactory {

    private lazy var secureStorage = SecureStorage()
    private lazy var networkService = NetworkService()
}

extension AppFactory {

    func makeValidateEmailUseCase() -> ValidateEmailUseCase {
        ValidateEmailUseCase()
    }

    func makeValidateUsernameUseCase() -> ValidateUsernameUseCase {
        ValidateUsernameUseCase()
    }

    func makeValidatePasswordUseCase() -> ValidatePasswordUseCase {
        ValidatePasswordUseCase()
    }

    func makeLoginUseCase() -> LoginUseCase {
        LoginUseCase(
            networkService: networkService,
            secureStorage: secureStorage
        )
    }

    func makeRegisterUserUseCase() -> RegisterUserUseCase {
        RegisterUserUseCase(
            networkService: networkService,
            secureStorage: secureStorage
        )
    }

    func makeUpdateUserInfoUseCase() -> UpdateUserInfoUseCase {
        UpdateUserInfoUseCase(
            networkService: networkService,
            secureStorage: secureStorage
        )
    }
}
