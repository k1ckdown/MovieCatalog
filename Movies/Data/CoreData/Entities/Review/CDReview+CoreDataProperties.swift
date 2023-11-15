//
//  CDReview+CoreDataProperties.swift
//  Movies
//
//  Created by Ivan Semenov on 15.11.2023.
//
//

import Foundation
import CoreData


extension CDReview {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDReview> {
        return NSFetchRequest<CDReview>(entityName: "CDReview")
    }

    @NSManaged public var createDateTime: Date
    @NSManaged public var id: String
    @NSManaged public var isAnonymous: Bool
    @NSManaged public var rating: Int32
    @NSManaged public var reviewText: String?
    @NSManaged public var author: CDUserShort?
    @NSManaged public var movie: CDMovie?

}

extension CDReview : Identifiable {

}
