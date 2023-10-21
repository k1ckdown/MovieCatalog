//
//  WelcomeNavigationState.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

final class WelcomeNavigationState: NavigationState {

    @Binding private(set) var path: NavigationPath

    init(path: Binding<NavigationPath>) {
        _path = path
    }
}

extension WelcomeNavigationState {
    enum Screen: RouteLink {
        case login
        case registration
    }
}

extension WelcomeNavigationState {
    enum Action {
        case showLogin
        case showRegistration
    }

    func execute(_ action: Action) {
        switch action {
        case .showLogin:
            path.append(Screen.login)
        case .showRegistration:
            path.append(Screen.registration)
        }
    }
}
