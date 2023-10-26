//
//  ScreenFactoryProtocols.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import SwiftUI

protocol LoginViewFactory {
    func makeLoginView(path: Binding<AuthNavigationPath>) -> LoginView
}

protocol WelcomeViewFactory {
    func makeWelcomeView(path: Binding<AuthNavigationPath>) -> WelcomeView
}

protocol PasswordRegistrationViewFactory {
    func makePasswordRegistrationView(path: Binding<AuthNavigationPath>) -> PasswordRegistrationView
}

protocol PersonalInfoRegistrationViewFactory {
    func makePersonalInfoRegistrationView(path: Binding<AuthNavigationPath>) -> PersonalInfoRegistrationView
}
