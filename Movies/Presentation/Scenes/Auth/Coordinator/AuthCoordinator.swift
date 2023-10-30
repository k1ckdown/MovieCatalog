//
//  AuthCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 24.10.2023.
//

import SwiftUI

typealias AuthNavigationPath = [AuthCoordinator.Screen]

final class AuthCoordinator: Coordinator {

    enum Screen: Routable {
        case login
        case personalInfoRegistration
        case passwordRegistration(PersonalInfoViewModel)
    }

    @Published var navigationPath = [Screen]()
}
