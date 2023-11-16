//
//  RealmManager.swift
//  Movies
//
//  Created by Ivan Semenov on 17.11.2023.
//

import Foundation
import RealmSwift

final class RealmManager {

    private let storage: Realm?

    init() {
        storage = try? Realm()
    }

    func read<T: Object>(by type: T.Type) -> [T]? {
        guard let storage else { return nil }
        return Array(storage.objects(type))
    }

    func delete(objects: [Object]) throws {
        try objects.forEach { try delete(object: $0) }
    }

    func delete(object: Object) throws {
        guard let storage else { return }

        try storage.write {
            storage.delete(object)
        }
    }

    func create(objects: [Object]) throws {
        try objects.forEach { try create(object: $0) }
    }

    func create(object: Object) throws {
        guard let storage else { return }

        storage.writeAsync {
            storage.add(object, update: .all)
        }
    }
}
