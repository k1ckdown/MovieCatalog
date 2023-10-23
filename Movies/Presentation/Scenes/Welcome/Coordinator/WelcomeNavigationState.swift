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
    enum Screen: Routable {
        case login
        case registration
    }

    func push(_ screen: Screen) {
        path.append(screen)
    }
}
