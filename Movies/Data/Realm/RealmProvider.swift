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
            realm = try? await Realm(actor: self)
        }

        return realm
    }
}
