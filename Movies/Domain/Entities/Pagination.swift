//
//  Pagination.swift
//  Movies
//
//  Created by Ivan Semenov on 11.11.2023.
//

import Foundation

struct Pagination {
    var pageCount: Int?
    var currentPage = 1

    var isLimitReached: Bool {
        guard let pageCount else { return false }
        return currentPage > pageCount
    }

    var page: Page = .first {
        didSet {
            currentPage = page == .first ? 1 : currentPage + 1
        }
    }
}

enum Page {
    case first
    case next
}
