//
//  ScreenFactory.swift
//  Movies
//
//  Created by Ivan Semenov on 22.10.2023.
//

import SwiftUI

@MainActor
final class ScreenFactory: AuthCoordinatorFactory,
                           HomeCoordinatorFactory,
                           ProfileCoordinatorFactory,
                           FavoritesCoordinatorFactory {

    private let appFactory: AppFactory

    init(appFactory: AppFactory) {
        self.appFactory = appFactory
    }
}

// MARK: - FavoritesViewFactory

extension ScreenFactory: FavoritesViewFactory {
    func makeFavoritesView(coordinator: FavoritesCoordinatorProtocol) -> FavoritesView {
        let viewModel = FavoritesViewModel(
            coordinator: coordinator,
            fetchFavoriteMoviesUseCase: appFactory.makeFetchFavoriteMoviesUseCase()
        )
        let view = FavoritesView(viewModel: viewModel)

        return view
    }
}

// MARK: - HomeViewFactory

extension ScreenFactory: HomeViewFactory {
    func makeHomeView(coordinator: HomeCoordinatorProtocol) -> HomeView {
        let viewModel = HomeViewModel(
            coordinator: coordinator,
            fetchMovieListUseCase: appFactory.makeFetchMovieListUseCase()
        )
        let view = HomeView(viewModel: viewModel)

        return view
    }
}

// MARK: - ProfileViewFactory

extension ScreenFactory: ProfileViewFactory {
    func makeProfileView(coordinator: ProfileCoordinatorProtocol) -> ProfileView {
        let viewModel = ProfileViewModel(
            coordinator: coordinator,
            logoutUseCase: appFactory.makeLogoutUseCase(),
            getProfileUseCase: appFactory.makeFetchProfileUseCase(),
            updateProfileUseCase: appFactory.makeUpdateProfileUseCase(),
            validateEmailUseCase: appFactory.makeValidateEmailUseCase()
        )
        let view = ProfileView(viewModel: viewModel)

        return view
    }
}

// MARK: - WelcomeViewFactory

extension ScreenFactory: WelcomeViewFactory {
    func makeWelcomeView(coordinator: AuthCoordinatorProtocol) -> WelcomeView {
        let viewModel = WelcomeViewModel(coordinator: coordinator)
        let view = WelcomeView(viewModel: viewModel)

        return view
    }
}

// MARK: - LoginViewFactory

extension ScreenFactory: LoginViewFactory {
    func makeLoginView(coordinator: AuthCoordinatorProtocol) -> LoginView {
        let viewModel = LoginViewModel(
            coordinator: coordinator,
            loginUseCase: appFactory.makeLoginUseCase()
        )
        let view = LoginView(viewModel: viewModel)

        return view
    }
}

// MARK: - PersonalInfoRegistrationViewFactory

extension ScreenFactory: PersonalInfoRegistrationViewFactory {
    func makePersonalInfoRegistrationView(
        coordinator: AuthCoordinatorProtocol
    ) -> PersonalInfoRegistrationView {
        let viewModel = PersonalInfoRegistrationViewModel(
            coordinator: coordinator,
            validateEmailUseCase: appFactory.makeValidateEmailUseCase(),
            validateUsernameUseCase: appFactory.makeValidateUsernameUseCase()
        )
        let view = PersonalInfoRegistrationView(viewModel: viewModel)

        return view
    }
}

// MARK: - PasswordRegistrationViewFactory

extension ScreenFactory: PasswordRegistrationViewFactory {
    func makePasswordRegistrationView(
        personalInfo: PersonalInfoViewModel,
        coordinator: AuthCoordinatorProtocol
    ) -> PasswordRegistrationView {
        let viewModel = PasswordRegistrationViewModel(
            personalInfo: personalInfo,
            coordinator: coordinator,
            registerUserUseCase: appFactory.makeRegisterUserUseCase(),
            validatePasswordUseCase: appFactory.makeValidatePasswordUseCase()
        )
        let view = PasswordRegistrationView(viewModel: viewModel)

        return view
    }
}

// MARK: - MovieDetailsFactory

extension ScreenFactory: MovieDetailsViewFactory {
    func makeMovieDetailsView(movieId: String, showAuthSceneHandler: @escaping () -> Void) -> MovieDetailsView {
        let router = MovieDetailsRouter(showAuthSceneHandler: showAuthSceneHandler)
        let viewModel = MovieDetailsViewModel(
            movieId: movieId,
            router: router,
            addReviewUseCase: appFactory.makeAddReviewUseCase(),
            updateReviewUseCase: appFactory.makeUpdateReviewUseCase(),
            deleteReviewUseCase: appFactory.makeDeleteReviewUseCase(),
            fetchMovieUseCase: appFactory.makeFetchMovieUseCase(),
            addFavoriteMovieUseCase: appFactory.makeAddFavoriteMovieUseCase(),
            deleteFavoriteMovieUseCase: appFactory.makeDeleteFavoriteMovieUseCase()
        )
        let view = MovieDetailsView(viewModel: viewModel)

        return view
    }
}
