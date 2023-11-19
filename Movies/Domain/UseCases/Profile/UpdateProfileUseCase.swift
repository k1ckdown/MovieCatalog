//
//  UpdateProfileUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

final class UpdateProfileUseCase {

    private let profileRepository: ProfileRepository
    private let closeSessionUseCase: CloseSessionUseCase

    init(
        profileRepository: ProfileRepository,
        closeSessionUseCase: CloseSessionUseCase
    ) {
        self.profileRepository = profileRepository
        self.closeSessionUseCase = closeSessionUseCase
    }
    
    func execute(_ profile: Profile) async throws {
        do {
            try await profileRepository.updateProfile(profile)
        } catch {
            if error as? AuthError == .unauthorized {
                try await closeSessionUseCase.execute()
            }

            throw error
        }
    }
}
