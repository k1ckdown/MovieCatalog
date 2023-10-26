//
//  PasswordRegistrationRouter.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import SwiftUI

final class PasswordRegistrationRouter {

    @Binding private var path: AuthNavigationPath

    init(path: Binding<AuthNavigationPath>) {
        _path = path
    }
}

extension PasswordRegistrationRouter {

    func showLogin() {
        (0...1).forEach { _ in
            path.removeLast()
        }

        path.append(.login)
    }

}
