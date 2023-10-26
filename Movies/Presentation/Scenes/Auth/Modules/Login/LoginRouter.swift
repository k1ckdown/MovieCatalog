//
//  LoginRouter.swift
//  Movies
//
//  Created by Ivan Semenov on 22.10.2023.
//

import SwiftUI

final class LoginRouter {

    @Binding private var path: AuthNavigationPath

    init(path: Binding<AuthNavigationPath>) {
        _path = path
    }
}

extension LoginRouter {

    func showRegistration() {
        path.removeLast()
        path.append(.personalInfoRegistration)
    }

}
