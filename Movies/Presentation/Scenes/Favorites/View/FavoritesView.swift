//
//  FavoritesView.swift
//  Movies
//
//  Created by Ivan Semenov on 01.11.2023.
//

import SwiftUI

struct FavoritesView: View {

    static let movies = Array(repeating: MovieDetails.mock, count: 9)
    let viewModels: [FavoritesMovieItemViewModel] = movies.map {
        .init(rating: $0.userRating, name: $0.name, imageUrl: $0.poster)
    }

    var body: some View {
        ScrollView(.vertical) {
                FavoritesLayout {
                    ForEach(viewModels) { itemViewModel in
                        FavoritesMovieItemView(viewModel: itemViewModel)
                    }
                }
                .padding(.horizontal, Constants.horizontalInset)
        }
        .scrollIndicators(.hidden)
        .appBackground()
    }

    private enum Constants {
        static let horizontalInset: CGFloat = 15
    }
}

#Preview {
    FavoritesView()
}
