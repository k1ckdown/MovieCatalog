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

    init(
        profileRepository: ProfileRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol
    ) {
        self.profileRepository = profileRepository
        self.keychainRepository = keychainRepository
    }

    func execute() async throws -> Profile {
        let token = try keychainRepository.retrieveToken()
        let profile = try await profileRepository.getProfile(token: token)

        return profile
    }
}
