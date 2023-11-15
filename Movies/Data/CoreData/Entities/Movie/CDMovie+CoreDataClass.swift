//
//  CDMovie+CoreDataClass.swift
//  Movies
//
//  Created by Ivan Semenov on 15.11.2023.
//
//

import Foundation
import CoreData

@objc(CDMovie)
public class CDMovie: NSManagedObject {

    func toDomain() -> Movie {
        var domainGenres: [Genre]?
        if let cdGenres = self.genres?.allObjects as? [CDGenre]  {
            domainGenres = cdGenres.map { $0.toDomain() }
        }

        var domainReviews: [Review]?
        if let cdReview = self.reviews?.allObjects as? [CDReview]  {
            domainReviews = cdReview.map { $0.toDomain() }
        }

        return .init(
            id: id,
            name: name,
            poster: poster,
            year: Int(year),
            country: country,
            genres: domainGenres,
            reviews: domainReviews,
            time: Int(time),
            tagline: tagline,
            description: descriptionText,
            director: director,
            budget: Int(budget),
            fees: Int(fees),
            ageLimit: Int(ageLimit)
        )
    }
}
