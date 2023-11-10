//
//  LogoutUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 09.11.2023.
//

import Foundation

final class LogoutUseCase {
    
    private let authRepository: AuthRepositoryProtocol
    private let keychainRepository: KeychainRepositoryProtocol
    private let closeSessionUseCase: CloseSessionUseCase
    
    init(
        authRepository: AuthRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol,
        closeSessionUseCase: CloseSessionUseCase
    ) {
        self.authRepository = authRepository
        self.keychainRepository = keychainRepository
        self.closeSessionUseCase = closeSessionUseCase
    }
    
    func execute() async throws {
        let token = try keychainRepository.retrieveToken()
        
        do {
            try await authRepository.logOut(token: token)
            try closeSessionUseCase.execute()
        } catch {
            if error as? AuthError == .unauthorized {
                try closeSessionUseCase.execute()
            }
            
            throw error
        }
    }
}
