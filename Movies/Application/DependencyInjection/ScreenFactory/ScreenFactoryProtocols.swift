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

protocol PersonalInfoRegistrationViewFactory {
    func makePersonalInfoRegistrationView(
        path: Binding<AuthNavigationPath>
    ) -> PersonalInfoRegistrationView
}

protocol PasswordRegistrationViewFactory {
    func makePasswordRegistrationView(
        personalInfo: PersonalInfoViewModel,
        path: Binding<AuthNavigationPath>
    ) -> PasswordRegistrationView
}
