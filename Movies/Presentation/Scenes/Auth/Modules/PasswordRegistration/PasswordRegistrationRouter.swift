//
//  PasswordRegistrationRouter.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import SwiftUI

final class PasswordRegistrationRouter {

    @Binding private(set) var path: [AuthFlowState.Screen]

    init(path: Binding<[AuthFlowState.Screen]>) {
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
