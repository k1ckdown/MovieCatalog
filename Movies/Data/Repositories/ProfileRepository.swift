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

    private let localDataSource: ProfileLocalDataSource
    private let profileRemoteDataSource: ProfileRemoteDataSource

    init(localDataSource: ProfileLocalDataSource, profileRemoteDataSource: ProfileRemoteDataSource) {
        self.localDataSource = localDataSource
        self.profileRemoteDataSource = profileRemoteDataSource
    }
}

extension ProfileRepository: ProfileRepositoryProtocol {

    func removeProfile() {
        try? localDataSource.deleteProfile()
    }

    func getProfile(token: String) async throws -> Profile {
        if let loadedProfile = profile {
            return loadedProfile
        }

        let profileDto = try await profileRemoteDataSource.fetchProfile(token: token)
        let profile = profileDto.toDomain()
        try? localDataSource.saveProfile(profile)

        return profile
    }

    func updateProfile(_ profile: Profile, token: String) async throws {
        let profileDto = ProfileDTO(
            id: profile.id,
            nickName: profile.nickName,
            email: profile.email,
            avatarLink: profile.avatarLink,
            name: profile.name,
            birthDate: DateFormatter.iso8601Full.string(from: profile.birthDate),
            gender: profile.gender == .male ? .male : .female)

        do {
            try await profileRemoteDataSource.updateProfile(token: token, profile: profileDto)
            try? localDataSource.saveProfile(profile)
        } catch {
            throw ProfileRepositoryError.updateFailed
        }
    }
}
