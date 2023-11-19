//
//  ProfileRepositoryImpl.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

final class ProfileRepositoryImpl {

    enum ProfileRepositoryError: LocalizedError {
        case notFound
        case updateFailed

        var errorDescription: String? {
            switch self {
            case .notFound:
                return LocalizedKey.ErrorMessage.Profile.notFound
            case .updateFailed:
                return LocalizedKey.ErrorMessage.Profile.updateFailed
            }
        }
    }

    private var isProfileLoaded = false
    private let localDataSource: ProfileLocalDataSource
    private let remoteDataSource: ProfileRemoteDataSource

    init(
        localDataSource: ProfileLocalDataSource,
        remoteDataSource: ProfileRemoteDataSource
    ) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
}

extension ProfileRepositoryImpl: ProfileRepository {

    func deleteProfile() async {
        await localDataSource.deleteProfile()
    }

    func getProfile() async throws -> Profile {
        if isProfileLoaded || NetworkMonitor.shared.isConnected == false,
           let localProfile = await localDataSource.fetchProfile() {
            return localProfile.toDomain()
        } else {
            let profileDto = try await remoteDataSource.fetchProfile()
            let profile = profileDto.toDomain()

            await localDataSource.saveProfile(ProfileObject(profile))
            isProfileLoaded = true

            return profile
        }
    }

    func updateProfile(_ profile: Profile) async throws {
        guard NetworkMonitor.shared.isConnected else { throw NetworkError.noConnect }

        let profileDto = ProfileDTO(
            id: profile.id,
            nickName: profile.nickName,
            email: profile.email,
            avatarLink: profile.avatarLink,
            name: profile.name,
            birthDate: DateFormatter.iso8601Full.string(from: profile.birthDate),
            gender: profile.gender == .male ? .male : .female
        )

        do {
            try await remoteDataSource.updateProfile(profile: profileDto)
            await localDataSource.saveProfile(ProfileObject(profile))
        } catch {
            throw ProfileRepositoryError.updateFailed
        }
    }
}
