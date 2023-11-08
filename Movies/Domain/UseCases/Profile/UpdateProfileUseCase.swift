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

    init(
        profileRepository: ProfileRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol
    ) {
        self.profileRepository = profileRepository
        self.keychainRepository = keychainRepository
    }

    func execute(_ profile: Profile) async throws {
        let token = try keychainRepository.retrieveToken()
        try await profileRepository.updateProfile(profile, token: token)
    }
}
