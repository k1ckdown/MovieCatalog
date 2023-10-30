//
//  AboutMovieViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

struct AboutMovieViewModel: Equatable {
    let year: Int
    let country: String
    let tagline: String
    let director: String
    let budget: Int
    let fees: Int
    let ageLimit: Int
    let time: Int
}
