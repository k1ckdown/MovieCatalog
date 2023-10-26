//
//  AuthNavigationState.swift
//  Movies
//
//  Created by Ivan Semenov on 24.10.2023.
//

import SwiftUI

typealias AuthNavigationPath = [AuthNavigationState.Screen]

final class AuthNavigationState: NavigationState {

    enum Screen: Routable {
        case login
        case personalInfoRegistration
        case passwordRegistration
    }

    @Published var navigationPath = [Screen]()
}
