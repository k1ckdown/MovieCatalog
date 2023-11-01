//
//  FavoritesMovieItemView.swift
//  Movies
//
//  Created by Ivan Semenov on 01.11.2023.
//

import SwiftUI

struct FavoritesMovieItemView: View {

    enum Size {
        case small
        case medium

        var width: CGFloat {
            switch self {
            case .small: 180
            case .medium: .infinity
            }
        }

        var height: CGFloat {
            switch self {
            case .small: 260
            case .medium: 240
            }
        }
    }

    let viewModel: FavoritesMovieItemViewModel

    var body: some View {
        MovieAsyncImage(urlString: viewModel.imageUrl)
            .frame(height: viewModel.size.height)
            .frame(maxWidth: viewModel.size.width)
            .clipShape(.rect(cornerRadius: Constants.cornerRadius))
            .overlay(alignment: .topTrailing, content: {
                if let rating = viewModel.rating {
                    RatingTagView(style: .titleAndIcon, value: Double(rating))
                        .padding([.top, .trailing], Constants.ratingTagInsets)
                }
            })
    }

    private enum Constants {
        static let cornerRadius: CGFloat = 7
        static let ratingTagInsets: CGFloat = 6
    }
}

#Preview {
    FavoritesMovieItemView(viewModel: .init(rating: 9, imageUrl: "fr", size: .medium))
}
