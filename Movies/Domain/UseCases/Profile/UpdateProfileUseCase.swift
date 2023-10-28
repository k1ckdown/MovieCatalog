//
//  UpdateProfileUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

final class UpdateProfileUseCase {

    private let secureStorage: SecureStorageProtocol
    private let profileRepository: ProfileRepositoryProtocol

    init(secureStorage: SecureStorageProtocol, profileRepository: ProfileRepositoryProtocol) {
        self.secureStorage = secureStorage
        self.profileRepository = profileRepository
    }

    func execute(_ profile: Profile) async throws {
        let token = try secureStorage.retrieveToken()
        try await profileRepository.updateProfile(profile, token: token)
    }
}
