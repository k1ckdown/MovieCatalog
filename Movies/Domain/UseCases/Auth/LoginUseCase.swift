//
//  LoginUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

final class LoginUseCase {
    
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute(username: String, password: String) async throws {
        let credentials = LoginCredentials(username: username, password: password)
        try await authRepository.logIn(credentials: credentials)
    }
}
