//
//  PersonalInfoRegistrationRouter.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import SwiftUI

final class PersonalInfoRegistrationRouter {

    @Binding private var path: [AuthFlowState.Screen]

    init(path: Binding<[AuthFlowState.Screen]>) {
        _path = path
    }
}

extension PersonalInfoRegistrationRouter {
    func showPasswordRegistration() {
        path.append(.passwordRegistration)
    }

    func showLogin() {
        path.removeLast()
        path.append(.login)
    }
}
