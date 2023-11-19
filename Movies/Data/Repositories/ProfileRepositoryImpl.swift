//
//  ProfileRepositoryImplementation.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

final class ProfileRepositoryImplementation {
    
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

extension ProfileRepositoryImplementation: ProfileRepository {
    
    func deleteProfile() async {
        await localDataSource.deleteProfile()
        isProfileLoaded = false
    }
    
    func getProfile() async throws -> Profile {
        if isProfileLoaded || NetworkMonitor.shared.isConnected == false,
           let localProfile = await localDataSource.fetchProfile() {
            return localProfile.toDomain()
        } else {
            do {
                let profileDto = try await remoteDataSource.fetchProfile()
                let profile = profileDto.toDomain()
                
                await localDataSource.saveProfile(ProfileObject(profile))
                isProfileLoaded = true
                
                return profile
            } catch {
                await handleUnauthorizedError(error)
                throw ProfileRepositoryError.notFound
            }
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
            await handleUnauthorizedError(error)
            throw ProfileRepositoryError.updateFailed
        }
    }
}

private extension ProfileRepositoryImplementation {
    
    func handleUnauthorizedError(_ error: Error) async {
        if error as? AuthError == .unauthorized {
            await deleteProfile()
        }
    }
}
