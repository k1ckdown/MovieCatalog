//
//  ProfileLocalDataSource.swift
//  Movies
//
//  Created by Ivan Semenov on 17.11.2023.
//

import Foundation
@preconcurrency import RealmSwift

final class ProfileLocalDataSource {

    private let realmProvider = RealmProvider()

    func fetchProfile() async -> ProfileObject? {
        guard let storage = await realmProvider.realm() else { return nil }
        return storage.objects(ProfileObject.self).first
    }

    func saveProfile(_ profileObject: ProfileObject) async {
        guard let storage = await realmProvider.realm() else { return }

        storage.writeAsync {
            storage.add(profileObject, update: .all)
        }
    }

    func deleteProfile() async {
        guard let storage = await realmProvider.realm() else { return }

        storage.writeAsync {
            storage.delete(storage.objects(ProfileObject.self))
        }
    }
}
