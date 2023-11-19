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

    private lazy var reviewRepository = ReviewRepositoryImpl(networkService: networkService)
    private lazy var authRepository = AuthRepositoryImpl(
        networkService: networkService,
        keychainService: keychainService
    )

    private lazy var movieRepository: MovieRepositoryImpl = {
        let localDataSource = MovieLocalDataSource()
        let remoteDataSource = MovieRemoteDataSource(networkService: networkService)

        return MovieRepositoryImpl(localDataSource: localDataSource, remoteDataSource: remoteDataSource)
    }()

    private lazy var profileRepository: ProfileRepositoryImpl = {
        let localDataSource = ProfileLocalDataSource()
        let remoteDataSource = ProfileRemoteDataSource(networkService: networkService)

        return ProfileRepositoryImpl(localDataSource: localDataSource, remoteDataSource: remoteDataSource)
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

    func makeFetchMovieListUseCase() -> FetchMovieListUseCase {
        FetchMovieListUseCase(
            movieRepository: movieRepository,
            getMovieDetailsUseCase: makeGetMovieDetailsUseCase()
        )
    }

    func makeFetchMovieUseCase() -> FetchMovieUseCase {
        FetchMovieUseCase(
            movieRepository: movieRepository,
            getMovieDetailsUseCase: makeGetMovieDetailsUseCase()
        )
    }
}

// MARK: - FavoriteMovie

extension AppFactory {

    func makeDeleteFavoriteMovieUseCase() -> DeleteFavoriteMovieUseCase {
        DeleteFavoriteMovieUseCase(movieRepository: movieRepository)
    }

    func makeAddFavoriteMovieUseCase() -> AddFavoriteMovieUseCase {
        AddFavoriteMovieUseCase(movieRepository: movieRepository)
    }

    func makeFetchFavoriteMoviesUseCase() -> FetchFavoriteMoviesUseCase {
        FetchFavoriteMoviesUseCase(
            movieRepository: movieRepository,
            getMovieDetailsUseCase: makeGetMovieDetailsUseCase()
        )
    }
}

// MARK: - Review

extension AppFactory {

    func makeAddReviewUseCase() -> AddReviewUseCase {
        AddReviewUseCase(reviewRepository: reviewRepository)
    }

    func makeUpdateReviewUseCase() -> UpdateReviewUseCase {
        UpdateReviewUseCase(reviewRepository: reviewRepository)
    }

    func makeDeleteReviewUseCase() -> DeleteReviewUseCase {
        DeleteReviewUseCase(reviewRepository: reviewRepository)
    }
}

private extension AppFactory {

    func makeGetMovieDetailsUseCase() -> GetMovieDetailsUseCase {
        GetMovieDetailsUseCase(
            movieRepository: movieRepository,
            profileRepository: profileRepository
        )
    }
}
