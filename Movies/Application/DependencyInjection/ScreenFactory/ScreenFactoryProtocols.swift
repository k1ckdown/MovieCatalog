//
//  ScreenFactoryProtocols.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import SwiftUI

protocol MainViewFactory {
    func makeMainView(coordinator: MainCoordinatorProtocol) -> MainView
}

protocol MovieDetailsFactory {
    func makeMovieDetailsView(movieDetails: MovieDetails) -> MovieDetailsView
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

protocol PasswordRegistrationViewFactory {
    func makePasswordRegistrationView(
        personalInfo: PersonalInfoViewModel,
        coordinator: AuthCoordinatorProtocol
    ) -> PasswordRegistrationView
}
