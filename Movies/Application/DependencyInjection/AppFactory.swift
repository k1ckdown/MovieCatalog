//
//  AppFactory.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

final class AppFactory {
    private lazy var networkService = NetworkService()
    private lazy var keychainRepository = KeychainRepository()
    private lazy var authRepository = AuthRepository(authDataSource: networkService)
    private lazy var movieRepository = MovieRepository(movieRemoteDataSource: networkService)
    private lazy var profileRepository = ProfileRepository(profileRemoteDataSource: networkService)
}

// MARK: - Profile

extension AppFactory {

    func makeFetchProfileUseCase() -> FetchProfileUseCase {
        FetchProfileUseCase(
            profileRepository: profileRepository,
            keychainRepository: keychainRepository
        )
    }

    func makeUpdateProfileUseCase() -> UpdateProfileUseCase {
        UpdateProfileUseCase(
            profileRepository: profileRepository,
            keychainRepository: keychainRepository
        )
    }
}

// MARK: - Validation

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
}

// MARK: - Auth

extension AppFactory {

    func makeLogoutUseCase() -> LogoutUseCase {
        LogoutUseCase(
            authRepository: authRepository,
            keychainRepository: keychainRepository
        )
    }

    func makeLoginUseCase() -> LoginUseCase {
        LoginUseCase(
            authRepository: authRepository,
            keychainRepository: keychainRepository
        )
    }

    func makeRegisterUserUseCase() -> RegisterUserUseCase {
        RegisterUserUseCase(
            authRepository: authRepository,
            keychainRepository: keychainRepository
        )
    }
}

// MARK: - Movie

extension AppFactory {

    func makeFetchMoviesUseCase() -> FetchMoviesUseCase {
        FetchMoviesUseCase(
            movieRepository: movieRepository,
            getDetailsFromMovies: makeGetDetailsFromMoviesUseCase()
        )
    }

    func makeAddFavoriteMovieUseCase() -> AddFavoriteMovieUseCase {
        AddFavoriteMovieUseCase(
            movieRepository: movieRepository,
            keychainRepository: keychainRepository
        )
    }

    func makeGetDetailsFromMoviesUseCase() -> GetDetailsFromMoviesUseCase {
        GetDetailsFromMoviesUseCase(
            movieRepository: movieRepository,
            profileRepository: profileRepository
        )
    }

    func makeFetchFavoriteMoviesUseCase() -> FetchFavoriteMoviesUseCase {
        FetchFavoriteMoviesUseCase(
            movieRepository: movieRepository,
            keychainRepository: keychainRepository,
            getDetailsFromMoviesUseCase: makeGetDetailsFromMoviesUseCase()
        )
    }
}
