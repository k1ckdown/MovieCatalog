//
//  CDReview+CoreDataClass.swift
//  Movies
//
//  Created by Ivan Semenov on 15.11.2023.
//
//

import Foundation
import CoreData

@objc(CDReview)
public class CDReview: NSManagedObject {

    func toDomain() -> Review {
        .init(
            id: id,
            rating: Int(rating),
            reviewText: reviewText,
            isAnonymous: isAnonymous,
            createDateTime: createDateTime,
            author: author?.toDomain()
        )
    }
}
