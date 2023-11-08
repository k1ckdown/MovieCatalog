//
//  ReviewShortDTO.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

struct ReviewShortDTO: Decodable {
    let id: String
    let rating: Int

    func toDomain() -> ReviewShort {
        .init(id: id, rating: rating)
    }
}
