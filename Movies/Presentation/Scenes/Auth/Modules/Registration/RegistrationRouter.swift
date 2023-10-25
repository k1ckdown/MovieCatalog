//
//  RegistrationRouter.swift
//  Movies
//
//  Created by Ivan Semenov on 24.10.2023.
//

import SwiftUI

final class RegistrationRouter {

    @Binding private var path: [AuthFlowState.Screen]

    init(path: Binding<[AuthFlowState.Screen]>) {
        _path = path
    }
}

extension RegistrationRouter {

    func showSecondStage() {
        path.append(.registrationSecondStage)
    }

    func showLogin() {
        if case .registrationSecondStage = path.last {
            path.removeLast()
        }

        path.removeLast()
        path.append(.login)
    }

}
