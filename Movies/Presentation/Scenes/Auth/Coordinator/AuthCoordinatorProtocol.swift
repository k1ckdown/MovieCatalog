//
//  AuthCoordinatorProtocol.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

@MainActor
protocol AuthCoordinatorProtocol {
    func showLogin()
    func showMainScene()
    func showPersonalInfoRegistration()
    func showPasswordRegistration(personalInfo: PersonalInfoViewModel)
}
