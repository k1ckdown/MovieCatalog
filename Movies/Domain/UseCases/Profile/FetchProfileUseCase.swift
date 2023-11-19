//
//  FetchProfileUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

final class FetchProfileUseCase {

    private let profileRepository: ProfileRepository

    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }

    @discardableResult
    func execute() async throws -> Profile {
        return try await profileRepository.getProfile()
    }
}
