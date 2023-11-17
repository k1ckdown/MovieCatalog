//
//  SceneScreenFactoryProtocols.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

protocol ProfileCoordinatorFactory: ProfileViewFactory {}

protocol FavoritesCoordinatorFactory: FavoritesViewFactory, MovieDetailsViewFactory {}

protocol HomeCoordinatorFactory: HomeViewFactory, MovieDetailsViewFactory {}

protocol AuthCoordinatorFactory: LoginViewFactory,
                                 WelcomeViewFactory,
                                 PasswordRegistrationViewFactory,
                                 PersonalInfoRegistrationViewFactory {}
