//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import SwiftUI

struct MovieDetailsView: View {

    let movie = MovieDetails.mock
    @State private var isFavorite = false

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                MovieAsyncImage(imageUrl: movie.poster)
                    .frame(height: Constants.posterHeight)

                VStack(spacing: Constants.Description.titleSpacing) {
                    HStack {
                        RatingTagView(style: .titleOnly(.medium), value: 9.0)

                        Spacer()

                        Text(movie.name ?? LocalizedKeysConstants.Content.notAvailable)
                            .bold()
                            .font(.title)
                            .multilineTextAlignment(.center)

                        Spacer()

                        FavoriteButton(isSet: $isFavorite)
                    }
                    .padding()

                    VStack(alignment: .leading, spacing: Constants.Description.contentSpacing) {
                        if let description = movie.description {
                            Text(description)
                                .padding(.bottom)
                        }

                        if let genres = movie.genres {
                            TagLayout(spacing: Constants.genresSpacing) {
                                ForEach(genres.compactMap { $0.name }, id: \.self) { genre in
                                    GenreTag(name: genre, style: .body)
                                }
                            }
                            .labeled(LocalizedKeysConstants.Content.genres, fontWeight: .bold)
                        }
                    }
                    .padding(.horizontal, Constants.Description.contentInsets)
                }

                Spacer()
            }
        }
        .scrollIndicators(.hidden)
        .appBackground()
    }

    private enum Constants {
        static let genresSpacing: CGFloat = 9
        static let posterHeight: CGFloat = 540

        enum Description {
            static let titleSpacing: CGFloat = 8
            static let contentInsets: CGFloat = 18
            static let contentSpacing: CGFloat = 30
        }
    }
}

#Preview {
    MovieDetailsView()
        .environment(\.locale, .init(identifier: "ru"))
}
