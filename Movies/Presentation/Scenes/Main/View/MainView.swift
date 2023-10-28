//
//  MainView.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import SwiftUI

struct MainView: View {

    let movieItems = MockData.movies.enumerated().map { index, value in
        MovieItemViewModel(
            id: "\(index)",
            name: value.name,
            year: "\(value.year)",
            country: value.country,
            poster: value.poster,
            rating: 9.0,
            userRating: 9,
            genres: value.genres.map { $0.name},
            shouldShowGenresEllipsis: false
        ) }

    var body: some View {
        List {
            Group {
                TabView {
                    ForEach(movieItems) { movie in
                        MovieAsyncImage(imageUrl: movie.poster)
                    }
                }
                .frame(height: Constants.MoviePage.height)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .listRowInsets(EdgeInsets())

                Text(LocalizedKeysConstants.Content.catalog)
                    .bold()
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding(.vertical, Constants.ListTitle.verticalInsets)

                ForEach(movieItems) { movie in
                    MovieItem(viewModel: movie)
                }
                .listRowInsets(Constants.ListItem.insets)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
        .appBackground()
    }

    private enum Constants {
        enum MoviePage {
            static let height: CGFloat = 515
        }

        enum ListTitle {
            static let verticalInsets: CGFloat = 5
        }

        enum ListItem {
            static let insets = EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15)
        }
    }
}

#Preview {
    MainView()
}
