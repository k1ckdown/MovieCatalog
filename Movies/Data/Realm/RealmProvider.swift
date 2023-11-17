//
//  RealmProvider.swift
//  Movies
//
//  Created by Ivan Semenov on 17.11.2023.
//

import Foundation
@preconcurrency import RealmSwift

actor RealmProvider {

    private var realm: Realm?

    func realm() async -> Realm? {
        if realm == nil {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            realm = try? await Realm(configuration: config, actor: self)
        }

        return realm
    }
}
