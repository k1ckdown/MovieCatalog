//
//  AppFactory.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

final class AppFactory {
    private lazy var keychainService = KeychainService()
    private lazy var networkService = NetworkService(keychainService: keychainService)

    private lazy var reviewRepository = ReviewRepositoryImplementation(networkService: networkService)
    private lazy var authRepository = AuthRepositoryImplementation(
        networkService: networkService,
        keychainService: keychainService
    )

    private lazy var movieRepository: MovieRepositoryImplementation = {
        let localDataSource = MovieLocalDataSource()
        let remoteDataSource = MovieRemoteDataSource(networkService: networkService)

        return MovieRepositoryImplementation(localDataSource: localDataSource, remoteDataSource: remoteDataSource)
    }()

    private lazy var profileRepository: ProfileRepositoryImplementation = {
        let localDataSource = ProfileLocalDataSource()
        let remoteDataSource = ProfileRemoteDataSource(networkService: networkService)

        return ProfileRepositoryImplementation(localDataSource: localDataSource, remoteDataSource: remoteDataSource)
    }()
}

// MARK: - Profile

extension AppFactory {

    func makeFetchProfileUseCase() -> FetchProfileUseCase {
        FetchProfileUseCase(profileRepository: profileRepository)
    }

    func makeUpdateProfileUseCase() -> UpdateProfileUseCase {
        UpdateProfileUseCase(profileRepository: profileRepository)
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

    func makeLoginUseCase() -> LoginUseCase {
        LoginUseCase(authRepository: authRepository)
    }

    func makeRegisterUserUseCase() -> RegisterUserUseCase {
        RegisterUserUseCase(authRepository: authRepository)
    }

    func makeLogoutUseCase() -> LogoutUseCase {
        LogoutUseCase(
            authRepository: authRepository,
            movieRepository: movieRepository,
            profileRepository: profileRepository
        )
    }
}

// MARK: - Movie

extension AppFactory {

    func makeFetchMovieUseCase() -> FetchMovieUseCase {
        FetchMovieUseCase(movieRepository: movieRepository)
    }

    func makeFetchMovieListUseCase() -> FetchMovieListUseCase {
        FetchMovieListUseCase(movieRepository: movieRepository)
    }

    func makeGetMovieDetailsUseCase() -> GetMovieDetailsUseCase {
        GetMovieDetailsUseCase(profileRepository: profileRepository)
    }
}

// MARK: - FavoriteMovie

extension AppFactory {

    func makeAddFavoriteMovieUseCase() -> AddFavoriteMovieUseCase {
        AddFavoriteMovieUseCase(movieRepository: movieRepository)
    }

    func makeDeleteFavoriteMovieUseCase() -> DeleteFavoriteMovieUseCase {
        DeleteFavoriteMovieUseCase(movieRepository: movieRepository)
    }

    func makeFetchFavoriteMoviesUseCase() -> FetchFavoriteMoviesUseCase {
        FetchFavoriteMoviesUseCase(movieRepository: movieRepository)
    }
}

// MARK: - Review

extension AppFactory {

    func makeAddReviewUseCase() -> AddReviewUseCase {
        AddReviewUseCase(reviewRepository: reviewRepository)
    }

    func makeDeleteReviewUseCase() -> DeleteReviewUseCase {
        DeleteReviewUseCase(reviewRepository: reviewRepository)
    }

    func makeUpdateReviewUseCase() -> UpdateReviewUseCase {
        UpdateReviewUseCase(reviewRepository: reviewRepository)
    }
}
