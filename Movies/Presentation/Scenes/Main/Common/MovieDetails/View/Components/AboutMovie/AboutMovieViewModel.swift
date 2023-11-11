//
//  AboutMovieViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

struct AboutMovieViewModel: Equatable {
    let year: String
    let country: String
    let tagline: String
    let director: String
    let budget: String
    let fees: String
    let ageLimit: String
    let time: String

    init(
        year: Int,
        country: String?,
        tagline: String?,
        director: String?,
        budget: Int?,
        fees: Int?,
        ageLimit: Int,
        time: Int
    ) {
        self.year = "\(year)"
        self.country = country ?? LocalizedKeysConstants.Content.notAvailable
        self.tagline = tagline ?? LocalizedKeysConstants.Content.notAvailable
        self.director = director ?? LocalizedKeysConstants.Content.notAvailable
        self.budget = AboutMovieViewModel.getMonetaryDescription(value: fees)
        self.fees = AboutMovieViewModel.getMonetaryDescription(value: fees)
        self.ageLimit = "\(ageLimit)+"
        self.time = "\(time) мин."
    }

    static func getMonetaryDescription(value: Int?) -> String {
        if let value {
            return "$\(value.formatted())"
        }

        return LocalizedKeysConstants.Content.notAvailable
    }
}

extension AboutMovieViewModel: HasPlaceholder {
    static func placeholder(id: String = "") -> AboutMovieViewModel {
        .init(
            year: 2077,
            country: .placeholder(length: 7),
            tagline: .placeholder(length: 15),
            director: .placeholder(length: 10),
            budget: 1000000000,
            fees: 1000000000,
            ageLimit: 0,
            time: 180
        )
    }
}
