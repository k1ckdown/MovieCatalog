//
//  UpdateProfileUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

final class UpdateProfileUseCase {

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
    
    func execute(_ profile: Profile) async throws {
        let token = try keychainRepository.retrieveToken()

        do {
            try await profileRepository.updateProfile(profile, token: token)
        } catch {
            if error as? AuthError == .unauthorized {
                try closeSessionUseCase.execute()
            }

            throw error
        }
    }
}
