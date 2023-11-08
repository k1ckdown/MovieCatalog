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

    func makeGetProfileUseCase() -> GetProfileUseCase {
        GetProfileUseCase(profileRepository: profileRepository)
    }

    func makeUpdateProfileUseCase() -> UpdateProfileUseCase {
        UpdateProfileUseCase(
            profileRepository: profileRepository,
            keychainRepository: keychainRepository
        )
    }

    func makeLoginUseCase() -> LoginUseCase {
        LoginUseCase(
            authRepository: authRepository,
            profileRepository: profileRepository,
            keychainRepository: keychainRepository
        )
    }

    func makeRegisterUserUseCase() -> RegisterUserUseCase {
        RegisterUserUseCase(
            authRepository: authRepository,
            profileRepository: profileRepository,
            keychainRepository: keychainRepository
        )
    }

    func makeGetDetailsFromMoviesUseCase() -> GetDetailsFromMoviesUseCase {
        GetDetailsFromMoviesUseCase(
            movieRepository: movieRepository,
            profileRepository: profileRepository
        )
    }

    func makeAddFavouriteMovieUseCase() -> AddFavouriteMovieUseCase {
        AddFavouriteMovieUseCase(
            movieRepository: movieRepository,
            keychainRepository: keychainRepository
        )
    }

    func makeFetchMoviesUseCase() -> FetchMoviesUseCase {
        FetchMoviesUseCase(
            movieRepository: movieRepository,
            getDetailsFromMovies: makeGetDetailsFromMoviesUseCase()
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
