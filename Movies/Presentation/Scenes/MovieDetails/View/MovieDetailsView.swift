//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import SwiftUI

struct MovieDetailsView: View {

    let movie = MovieDetails.mock

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                MovieAsyncImage(imageUrl: movie.poster ?? "")
                    .frame(height: 540)

                VStack(spacing: 18) {
                    HStack {
                        RatingTagView(style: .titleOnly(.medium), value: 9.0)

                        Spacer()

                        Text(movie.name ?? LocalizedKeysConstants.Content.notAvailable)
                            .bold()
                            .font(.title)
                            .multilineTextAlignment(.center)

                        Spacer()

                        Image(systemName: "heart")
                            .imageScale(.large)
                            .fontWeight(.medium)
                            .padding(9)
                            .background(
                                Circle().fill(.pebble)
                            )
                    }
                    .padding()

                    VStack(spacing: 30) {
                        if let description = movie.description {
                            Text(description)
                                .font(.body)
                        }

                        if let genres = movie.genres {
                            TagLayout {
                                ForEach(genres.compactMap { $0.name }, id: \.self) { genre in
                                    Text(genre)
                                        .padding(7)
                                        .background(.appAccent)
                                        .clipShape(.rect(cornerRadius: 10))
                                }
                            }
                            .labeled("Жанры")
                        }

                        VStack {
                            
                        }
                    }
                    .padding(.horizontal, 10)
                }

                Spacer()
            }
        }
        .appBackground()
    }
}

#Preview {
    MovieDetailsView()
}
