//
//  ReviewDTO.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

struct ReviewDTO: Decodable {
    let id: String
    let rating: Int?
    let reviewText: String?
    let isAnonymous: Bool
    let createDateTime: String?
    let author: UserShortDTO

    func toDomain() -> Review {
        .init(
            id: id,
            rating: rating,
            reviewText: reviewText,
            isAnonymous: isAnonymous,
            createDateTime: try? Date(createDateTime ?? "", strategy: .iso8601),
            author: author.toDomain()
        )
    }
}
