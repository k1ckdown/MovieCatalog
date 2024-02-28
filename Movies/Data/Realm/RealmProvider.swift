//
//  RealmProvider.swift
//  Movies
//
//  Created by Ivan Semenov on 17.11.2023.
//

import Foundation
import RealmSwift

final class RealmProvider {

    private var realm: Realm?

    func realm() async -> Realm? {
        if realm == nil {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            realm = try? await Realm(configuration: config, actor: RealmActor.shared)
        }

        return realm
    }
}
