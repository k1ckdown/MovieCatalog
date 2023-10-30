//
//  MovieItem.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import SwiftUI

struct MovieItem: View {

    let viewModel: MovieItemViewModel

    init(viewModel: MovieItemViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack(spacing: Constants.Content.spacing) {
            MovieAsyncImage(imageUrl: viewModel.poster)
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

                        Text("\(viewModel.year.description) • \(viewModel.country)")
                            .font(.subheadline)
                    }

                    Spacer()

                    if let userRating = viewModel.userRating {
                        RatingTagView(style: .titleAndIcon, value: Double(userRating))
                    }
                }

                TagLayout {
                    ForEach(viewModel.genres, id: \.self) { genre in
                        GenreTag(name: genre, style: .note)
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
    }

    private enum Constants {
        enum Content {
            static let spacing: CGFloat = 13
            static let height: CGFloat = 140
        }

        enum MovieImage {
            static let width: CGFloat = 105
            static let ratingInsets: CGFloat = 5
            static let cornerRadius: CGFloat = 5
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
    let mock = MovieShort.mockedMovie
    let viewModel = MovieItemViewModel(
        id: mock.id,
        name: mock.name ?? "",
        year: mock.year,
        country: mock.country ?? "",
        poster: mock.poster ?? "",
        rating: 3.444,
        userRating: 8,
        genres: mock.genres?.compactMap { $0.name } ?? [],
        shouldShowGenresEllipsis: false
    )

    return MovieItem(viewModel: viewModel)
}
