//
//  FavoritesView.swift
//  Movies
//
//  Created by Ivan Semenov on 01.11.2023.
//

import SwiftUI

struct FavoritesView: View {

    static let movies = Array(repeating: MovieDetails.mock, count: 9)
    let viewModels: [FavoritesMovieItemViewModel] = movies.map { .init(rating: $0.userRating, imageUrl: $0.poster) }

    var body: some View {
        ScrollView(.vertical) {
                FavoritesLayout {
                    ForEach(Array(viewModels.enumerated()) ,id: \.offset) { index, model in
                        FavoritesMovieItemView(viewModel: model)
                            .onTapGesture {
                                print(index)
                            }
                    }
                }
                .padding(.horizontal, 15)
        }
        .scrollIndicators(.hidden)
        .appBackground()
    }
}

#Preview {
    FavoritesView()
}
