//
//  LogoutUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 09.11.2023.
//

import Foundation

final class LogoutUseCase {
    
    private let authRepository: AuthRepository
    private let closeSessionUseCase: CloseSessionUseCase
    
    init(
        authRepository: AuthRepository,
        closeSessionUseCase: CloseSessionUseCase
    ) {
        self.authRepository = authRepository
        self.closeSessionUseCase = closeSessionUseCase
    }
    
    func execute() async throws {
        do {
            try await authRepository.logOut()
            try await closeSessionUseCase.execute()
        } catch {
            if error as? AuthError == .unauthorized {
                try await closeSessionUseCase.execute()
            }
            
            throw error
        }
    }
}
