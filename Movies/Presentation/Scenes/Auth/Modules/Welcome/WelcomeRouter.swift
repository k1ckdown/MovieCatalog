//
//  WelcomeRouter.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

final class WelcomeRouter {

    @Binding private var path: AuthNavigationPath

    init(path: Binding<AuthNavigationPath>) {
        _path = path
    }
}

extension WelcomeRouter {

    func showLogin() {
        path.append(.login)
    }

    func showRegistration() {
        path.append(.personalInfoRegistration)
    }

}
