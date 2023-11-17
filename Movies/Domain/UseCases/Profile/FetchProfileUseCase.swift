//
//  FetchProfileUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

final class FetchProfileUseCase {

    private let profileRepository: ProfileRepositoryProtocol
    private let keychainRepository: KeychainRepositoryProtocol
    private let closeSessionUseCase: CloseSessionUseCase

    init(
        profileRepository: ProfileRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol,
        closeSessionUseCase: CloseSessionUseCase
    ) {
        self.profileRepository = profileRepository
        self.keychainRepository = keychainRepository
        self.closeSessionUseCase = closeSessionUseCase
    }

    @discardableResult
    func execute() async throws -> Profile {
        let token = try keychainRepository.retrieveToken()
        
        do {
            let profile = try await profileRepository.getProfile(token: token)
            return profile
        } catch {
            if error as? AuthError == .unauthorized {
                try await closeSessionUseCase.execute()
            }

            throw error
        }
    }
}
