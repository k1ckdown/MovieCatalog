//
//  HomeCoordinatorProtocol.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

@MainActor
protocol HomeCoordinatorProtocol {
    func showMovieDetails(_ movieId: String, ratingUpdateHandler: RatingUpdateHandler)
}
