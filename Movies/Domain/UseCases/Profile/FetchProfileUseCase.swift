//
//  FetchProfileUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

final class FetchProfileUseCase {

    private let profileRepository: ProfileRepository
    private let closeSessionUseCase: CloseSessionUseCase

    init(
        profileRepository: ProfileRepository,
        closeSessionUseCase: CloseSessionUseCase
    ) {
        self.profileRepository = profileRepository
        self.closeSessionUseCase = closeSessionUseCase
    }

    @discardableResult
    func execute() async throws -> Profile {
        do {
            let profile = try await profileRepository.getProfile()
            return profile
        } catch {
            if error as? AuthError == .unauthorized {
                try await closeSessionUseCase.execute()
            }

            throw error
        }
    }
}
