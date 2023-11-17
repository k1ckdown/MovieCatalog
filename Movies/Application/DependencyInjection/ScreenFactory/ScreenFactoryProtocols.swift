//
//  ScreenFactoryProtocols.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import SwiftUI

@MainActor
protocol ProfileViewFactory {
    func makeProfileView(coordinator: ProfileCoordinatorProtocol) -> ProfileView
}

@MainActor
protocol FavoritesViewFactory {
    func makeFavoritesView(coordinator: FavoritesCoordinatorProtocol) -> FavoritesView
}

@MainActor
protocol HomeViewFactory {
    func makeHomeView(coordinator: HomeCoordinatorProtocol) -> HomeView
}

@MainActor
protocol LoginViewFactory {
    func makeLoginView(coordinator: AuthCoordinatorProtocol) -> LoginView
}

@MainActor
protocol WelcomeViewFactory {
    func makeWelcomeView(coordinator: AuthCoordinatorProtocol) -> WelcomeView
}

@MainActor
protocol PersonalInfoRegistrationViewFactory {
    func makePersonalInfoRegistrationView(
        coordinator: AuthCoordinatorProtocol
    ) -> PersonalInfoRegistrationView
}

@MainActor
protocol MovieDetailsViewFactory {
    func makeMovieDetailsView(
        movieId: String,
        showAuthSceneHandler: @escaping () -> Void
    ) -> MovieDetailsView
}

@MainActor
protocol PasswordRegistrationViewFactory {
    func makePasswordRegistrationView(
        personalInfo: PersonalInfoViewModel,
        coordinator: AuthCoordinatorProtocol
    ) -> PasswordRegistrationView
}
