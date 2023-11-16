//
//  ProfileLocalDataSource.swift
//  Movies
//
//  Created by Ivan Semenov on 17.11.2023.
//

import Foundation

final class ProfileLocalDataSource {

    private var profileObject: ProfileObject?
    private let realmManager: RealmManager = .init()

    func fetchProfile() -> ProfileObject? {
        let profileObject = realmManager.read(by: ProfileObject.self)?.first
        self.profileObject = profileObject

        return profileObject
    }

    func saveProfile(_ profile: Profile) throws {
        let profileObject = ProfileObject(profile)
        self.profileObject = profileObject

        try realmManager.create(object: profileObject)
    }

    func deleteProfile() throws {
        guard let profileObject else { return }
        try realmManager.delete(object: profileObject)
    }
}
