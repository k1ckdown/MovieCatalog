//
//  CDUserShort+CoreDataProperties.swift
//  Movies
//
//  Created by Ivan Semenov on 15.11.2023.
//
//

import Foundation
import CoreData


extension CDUserShort {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUserShort> {
        return NSFetchRequest<CDUserShort>(entityName: "CDUserShort")
    }

    @NSManaged public var avatar: String?
    @NSManaged public var nickname: String?
    @NSManaged public var userId: String
    @NSManaged public var review: CDReview?

}

extension CDUserShort : Identifiable {

}
