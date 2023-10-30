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
    private lazy var movieRepository = MovieRepository(networkService: networkService)
    private lazy var profileRepository = ProfileRepository(networkService: networkService)
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
            secureStorage: secureStorage,
            profileRepository: profileRepository
        )
    }

    func makeRegisterUserUseCase() -> RegisterUserUseCase {
        RegisterUserUseCase(
            networkService: networkService,
            secureStorage: secureStorage,
            profileRepository: profileRepository
        )
    }

    func makeUpdateUserInfoUseCase() -> UpdateProfileUseCase {
        UpdateProfileUseCase(
            secureStorage: secureStorage,
            profileRepository: profileRepository
        )
    }

    func makeFetchMoviesUseCase() -> FetchMoviesUseCase {
        FetchMoviesUseCase(
            movieRepository: movieRepository,
            profileRepository: profileRepository
        )
    }
}
