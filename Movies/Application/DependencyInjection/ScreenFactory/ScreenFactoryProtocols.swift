//
//  ScreenFactoryProtocols.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import SwiftUI

protocol ProfileViewFactory {
    func makeProfileView(coordinator: ProfileCoordinatorProtocol) -> ProfileView
}

protocol FavoritesViewFactory {
    func makeFavoritesView(coordinator: FavoritesCoordinatorProtocol) -> FavoritesView
}

protocol HomeViewFactory {
    func makeHomeView(coordinator: HomeCoordinatorProtocol) -> HomeView
}

protocol LoginViewFactory {
    func makeLoginView(coordinator: AuthCoordinatorProtocol) -> LoginView
}

protocol WelcomeViewFactory {
    func makeWelcomeView(coordinator: AuthCoordinatorProtocol) -> WelcomeView
}

protocol PersonalInfoRegistrationViewFactory {
    func makePersonalInfoRegistrationView(
        coordinator: AuthCoordinatorProtocol
    ) -> PersonalInfoRegistrationView
}

protocol MovieDetailsViewFactory {
    func makeMovieDetailsView(
        movieId: String,
        showAuthSceneHandler: @escaping () -> Void
    ) -> MovieDetailsView
}

protocol PasswordRegistrationViewFactory {
    func makePasswordRegistrationView(
        personalInfo: PersonalInfoViewModel,
        coordinator: AuthCoordinatorProtocol
    ) -> PasswordRegistrationView
}
