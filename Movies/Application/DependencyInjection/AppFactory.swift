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
    private lazy var authRepository = AuthRepository(networkService: networkService)
    private lazy var reviewRepository = ReviewRepository(networkService: networkService)

    private lazy var movieRepository: MovieRepository = {
        let remoteDataSource = MovieRemoteDataSource(networkService: networkService)
        return MovieRepository(remoteDataSource: remoteDataSource)
    }()

    private lazy var profileRepository: ProfileRepository = {
        let localDataSource = ProfileLocalDataSource()
        let remoteDataSource = ProfileRemoteDataSource(networkService: networkService)

        return ProfileRepository(localDataSource: localDataSource, remoteDataSource: remoteDataSource)
    }()
}

// MARK: - Profile

extension AppFactory {

    func makeFetchProfileUseCase() -> FetchProfileUseCase {
        FetchProfileUseCase(
            profileRepository: profileRepository,
            keychainRepository: keychainRepository,
            closeSessionUseCase: makeCloseSessionUseCase()
        )
    }

    func makeUpdateProfileUseCase() -> UpdateProfileUseCase {
        UpdateProfileUseCase(
            profileRepository: profileRepository,
            keychainRepository: keychainRepository,
            closeSessionUseCase: makeCloseSessionUseCase()
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
            keychainRepository: keychainRepository,
            closeSessionUseCase: makeCloseSessionUseCase()
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

    func makeFetchMovieListUseCase() -> FetchMovieListUseCase {
        FetchMovieListUseCase(
            movieRepository: movieRepository,
            makeMovieDetailsUseCase: makeMakeMovieDetailsUseCase()
        )
    }

    func makeFetchMovieUseCase() -> FetchMovieUseCase {
        FetchMovieUseCase(
            movieRepository: movieRepository,
            keychainRepository: keychainRepository,
            makeMovieDetailsUseCase: makeMakeMovieDetailsUseCase()
        )
    }
}

// MARK: - FavoriteMovie

extension AppFactory {

    func makeDeleteFavoriteMovieUseCase() -> DeleteFavoriteMovieUseCase {
        DeleteFavoriteMovieUseCase(
            closeSessionUseCase: makeCloseSessionUseCase(),
            movieRepository: movieRepository,
            keychainRepository: keychainRepository
        )
    }

    func makeAddFavoriteMovieUseCase() -> AddFavoriteMovieUseCase {
        AddFavoriteMovieUseCase(
            movieRepository: movieRepository,
            keychainRepository: keychainRepository,
            closeSessionUseCase: makeCloseSessionUseCase()
        )
    }

    func makeFetchFavoriteMoviesUseCase() -> FetchFavoriteMoviesUseCase {
        FetchFavoriteMoviesUseCase(
            movieRepository: movieRepository,
            keychainRepository: keychainRepository,
            closeSessionUseCase: makeCloseSessionUseCase(),
            makeMovieDetailsUseCase: makeMakeMovieDetailsUseCase()
        )
    }
}

// MARK: - Review

extension AppFactory {

    func makeAddReviewUseCase() -> AddReviewUseCase {
        AddReviewUseCase(
            closeSessionUseCase: makeCloseSessionUseCase(),
            reviewRepository: reviewRepository,
            keychainRepository: keychainRepository
        )
    }

    func makeUpdateReviewUseCase() -> UpdateReviewUseCase {
        UpdateReviewUseCase(
            closeSessionUseCase: makeCloseSessionUseCase(),
            reviewRepository: reviewRepository,
            keychainRepository: keychainRepository
        )
    }

    func makeDeleteReviewUseCase() -> DeleteReviewUseCase {
        DeleteReviewUseCase(
            closeSessionUseCase: makeCloseSessionUseCase(),
            reviewRepository: reviewRepository,
            keychainRepository: keychainRepository
        )
    }
}

private extension AppFactory {

    func makeCloseSessionUseCase() -> CloseSessionUseCase {
        CloseSessionUseCase(
            profileRepository: profileRepository,
            keychainRepository: keychainRepository
        )
    }

    func makeMakeMovieDetailsUseCase() -> MakeMovieDetailsUseCase {
        MakeMovieDetailsUseCase(
            movieRepository: movieRepository,
            profileRepository: profileRepository,
            keychainRepository: keychainRepository
        )
    }
}
