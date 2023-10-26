//
//  ReviewModifyDTO.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

struct ReviewModifyDTO: Encodable {
    let reviewText: String
    let rating: Int
    let isAnonymous: Bool
}
