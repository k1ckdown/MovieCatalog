//
//  CoreDataManager.swift
//  Movies
//
//  Created by Ivan Semenov on 15.11.2023.
//

import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager(modelName: "Movie")

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    private let persistentContainer: NSPersistentContainer

    private init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)

        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data store failed to load: \(error)")
            }
        }
    }
}
