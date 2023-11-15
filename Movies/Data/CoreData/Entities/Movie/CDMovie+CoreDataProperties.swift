//
//  CDMovie+CoreDataProperties.swift
//  Movies
//
//  Created by Ivan Semenov on 15.11.2023.
//
//

import Foundation
import CoreData


extension CDMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMovie> {
        return NSFetchRequest<CDMovie>(entityName: "CDMovie")
    }

    @NSManaged public var ageLimit: Int32
    @NSManaged public var budget: Int32
    @NSManaged public var country: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var director: String?
    @NSManaged public var fees: Int32
    @NSManaged public var id: String
    @NSManaged public var name: String?
    @NSManaged public var poster: String?
    @NSManaged public var tagline: String?
    @NSManaged public var time: Int32
    @NSManaged public var year: Int32
    @NSManaged public var genres: NSSet?
    @NSManaged public var reviews: NSSet?

}

// MARK: Generated accessors for genres
extension CDMovie {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: CDGenre)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: CDGenre)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}

// MARK: Generated accessors for reviews
extension CDMovie {

    @objc(addReviewsObject:)
    @NSManaged public func addToReviews(_ value: CDReview)

    @objc(removeReviewsObject:)
    @NSManaged public func removeFromReviews(_ value: CDReview)

    @objc(addReviews:)
    @NSManaged public func addToReviews(_ values: NSSet)

    @objc(removeReviews:)
    @NSManaged public func removeFromReviews(_ values: NSSet)

}

extension CDMovie : Identifiable {

}
