//
//  ProfileLocalDataSource.swift
//  Movies
//
//  Created by Ivan Semenov on 17.11.2023.
//

import Foundation
@preconcurrency import RealmSwift

final class ProfileLocalDataSource {

    private var profileObject: ProfileObject?
    private let realmProvider = RealmProvider()

    func fetchProfile() async -> ProfileObject? {
        guard let storage = await realmProvider.realm() else { return nil }

        let profileObjects = storage.objects(ProfileObject.self)
        self.profileObject = profileObjects.first

        return profileObject
    }

    func saveProfile(_ profileObject: ProfileObject) async throws {
        guard let storage = await realmProvider.realm() else { return }

        self.profileObject = profileObject
        storage.writeAsync {
            storage.add(profileObject, update: .all)
        }
    }

    func deleteProfile() async throws {
        guard
            let storage = await realmProvider.realm(),
            let profileObject
        else { return }

        storage.writeAsync {
            storage.delete(profileObject)
        }
    }
}
