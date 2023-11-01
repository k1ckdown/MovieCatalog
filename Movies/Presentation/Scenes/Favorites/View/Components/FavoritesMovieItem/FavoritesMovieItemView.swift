//
//  FavoritesMovieItemView.swift
//  Movies
//
//  Created by Ivan Semenov on 01.11.2023.
//

import SwiftUI

struct FavoritesMovieItemView: View {

    let viewModel: FavoritesMovieItemViewModel

    var body: some View {
        VStack(alignment: .leading) {
            MovieAsyncImage(urlString: viewModel.imageUrl)
                .clipShape(.rect(cornerRadius: Constants.cornerRadius))
                .overlay(alignment: .topTrailing, content: {
                    if let rating = viewModel.rating {
                        RatingTagView(style: .titleAndIcon, value: Double(rating))
                            .padding([.top, .trailing], Constants.ratingTagInsets)
                    }
                })

            if let name = viewModel.name {
                Text(name)
                    .font(.callout)
            }
        }
    }

    private enum Constants {
        static let cornerRadius: CGFloat = 7
        static let ratingTagInsets: CGFloat = 6
    }
}
