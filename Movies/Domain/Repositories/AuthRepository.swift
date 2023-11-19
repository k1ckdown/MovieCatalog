//
//  AuthRepository.swift
//  Movies
//
//  Created by Ivan Semenov on 08.11.2023.
//

import Foundation

protocol AuthRepository {
    func logOut() async throws
    func register(user: UserRegister) async throws
    func logIn(credentials: LoginCredentials) async throws
}
