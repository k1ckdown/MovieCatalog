//
//  MovieItemView.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import SwiftUI

struct MovieItemView: View {

    let viewModel: MovieItemViewModel

    init(viewModel: MovieItemViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack(spacing: Constants.Content.spacing) {
            MovieAsyncImage(imageUrl: viewModel.imageUrl)
                .frame(width: Constants.MovieImage.width)
                .clipShape(.rect(cornerRadius: Constants.MovieImage.cornerRadius))
                .overlay(alignment: .topLeading) {
                    RatingTagView(style: .titleOnly(.small), value: viewModel.rating)
                        .padding([.top, .leading], Constants.MovieImage.ratingInsets)
                }

            VStack(alignment: .leading, spacing: Constants.Details.spacing) {
                HStack(alignment: .top, spacing: Constants.Details.tagSpacing) {
                    VStack(alignment: .leading, spacing: Constants.Details.descriptionSpacing) {
                        Text(viewModel.name)
                            .font(.system(size: Constants.Details.nameFontSize, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("\(viewModel.year) • \(viewModel.country)")
                            .font(.callout)
                    }

                    Spacer()

                    RatingTagView(style: .titleAndIcon, value: Double(viewModel.userRating))
                }

                TagLayout {
                    ForEach(viewModel.genres, id: \.self) { genre in
                        GenreItem(name: genre)
                    }

                    if viewModel.shouldShowGenresEllipsis {
                        Text(Constants.Details.ellipsis)
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: Constants.Content.height)
        .padding(.horizontal)
        .appBackground()
    }

    private enum Constants {
        enum Content {
            static let spacing: CGFloat = 13
            static let height: CGFloat = 165
        }

        enum MovieImage {
            static let width: CGFloat = 117
            static let ratingInsets: CGFloat = 4
            static let cornerRadius: CGFloat = 10
        }

        enum Details {
            static let ellipsis = "..."
            static let nameFontSize: CGFloat = 19

            static let spacing: CGFloat = 15
            static let tagSpacing: CGFloat = 0
            static let descriptionSpacing: CGFloat = 8
        }
    }
}

#Preview {
    let mock = MockData.movie
    let viewModel = MovieItemViewModel(
        id: mock.id,
        name: mock.name,
        year: "\(mock.year)",
        country: mock.country,
        imageUrl: URL(string: mock.poster),
        rating: 3.0,
        userRating: 8,
        genres: mock.genres.map { $0.name ?? "" },
        shouldShowGenresEllipsis: false
    )

    return MovieItemView(viewModel: viewModel)
}
