//
//  CDGenre+CoreDataProperties.swift
//  Movies
//
//  Created by Ivan Semenov on 15.11.2023.
//
//

import Foundation
import CoreData


extension CDGenre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGenre> {
        return NSFetchRequest<CDGenre>(entityName: "CDGenre")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String?
    @NSManaged public var movie: CDMovie?

}

extension CDGenre : Identifiable {

}
