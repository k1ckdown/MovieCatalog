//
//  PageInfoDTO.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

struct PageInfoDTO: Decodable {
    let pageSize: Int
    let pageCount: Int
    let currentPage: Int

    func toDomain() -> PageInfo {
        .init(
            pageSize: pageSize,
            pageCount: pageCount,
            currentPage: currentPage
        )
    }
}
