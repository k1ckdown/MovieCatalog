//
//  LoginNavigationState.swift
//  Movies
//
//  Created by Ivan Semenov on 22.10.2023.
//

import SwiftUI

final class LoginNavigationState: NavigationState {

    @Binding private(set) var path: NavigationPath

    init(path: Binding<NavigationPath>) {
        _path = path
    }
}

extension LoginNavigationState {
    enum Screen: Routable {
        case registration
    }

    func push(_ screen: Screen) {
        path.append(screen)
    }
}
