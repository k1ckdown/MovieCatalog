//
//  PersonalInfoRegistrationRouter.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import SwiftUI

final class PersonalInfoRegistrationRouter {

    @Binding private var path: AuthNavigationPath

    init(path: Binding<AuthNavigationPath>) {
        _path = path
    }
}

extension PersonalInfoRegistrationRouter {

    func showPasswordRegistration(personalInfo: PersonalInfoViewModel) {
        path.append(.passwordRegistration(personalInfo))
    }

    func showLogin() {
        path.removeLast()
        path.append(.login)
    }

}
