//
//  ProfileRepository.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

final class ProfileRepository {

    enum ProfileRepositoryError: LocalizedError {
        case notFound
        case updateFailed

        var errorDescription: String? {
            switch self {
            case .notFound:
                return "Profile not found"
            case .updateFailed:
                return "Profile update failed"
            }
        }
    }

    private var profile: Profile?
    private let networkService: UserNetworkService

    init(networkService: UserNetworkService) {
        self.networkService = networkService
    }
}

extension ProfileRepository: ProfileRepositoryProtocol {

    func loadProfile(token: String) async throws {
        let profile = try await networkService.fetchProfile(token: token)
        self.profile = profile.toDomain()
    }

    func getProfile() async throws -> Profile {
        guard let profile = profile else {
            throw ProfileRepositoryError.notFound
        }

        return profile
    }
    
    func updateProfile(_ profile: Profile, token: String) async throws {
        let profileDto = ProfileDTO(
            id: profile.id,
            nickName: profile.nickName,
            email: profile.email,
            avatarLink: profile.avatarLink,
            name: profile.name,
            birthDate: profile.birthDate.ISO8601Format(),
            gender: profile.gender == .male ? .male : .female)

        do {
            try await networkService.updateProfile(token: token, profile: profileDto)
            self.profile = profile
        } catch {
            throw ProfileRepositoryError.updateFailed
        }
    }
}
