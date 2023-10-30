//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import SwiftUI

struct MovieDetailsView: View {

    @ObservedObject private(set) var viewModel: MovieDetailsViewModel

    var body: some View {
        contentView
            .appBackground()
            .onAppear {
                viewModel.handle(.onAppear)
            }
    }

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .idle:
            EmptyView()
        case .loaded(let viewData):
            detailsView(data: viewData)
        }
    }

    private enum Constants {
        static let genresSpacing: CGFloat = 9
        static let reviewsSpacing: CGFloat = 18
        static let posterHeight: CGFloat = 540
        static let contentSpacing: CGFloat = -15
        static let gradientEndOpacity: CGFloat = 0.4
        static let sectionHeaderFontSize: CGFloat = 18

        enum Description {
            static let titleSpacing: CGFloat = 8
            static let contentInsets: CGFloat = 18
            static let contentSpacing: CGFloat = 30
        }
    }
}

private extension MovieDetailsView {

    func detailsView(data: MovieDetailsViewState.ViewData) -> some View {
        ScrollView(.vertical) {
            VStack(spacing: Constants.contentSpacing) {
                posterView(data.poster)

                VStack(spacing: Constants.Description.titleSpacing) {
                    headerView(name: data.name, rating: data.rating, isFavorite: data.isFavorite)

                    VStack(alignment: .leading, spacing: Constants.Description.contentSpacing) {
                        if let description = data.description {
                            ExpandableText(text: description)
                        }

                        if let genres = data.genres {
                            genreListView(genres: genres)
                        }

                        aboutMovieView(viewModel: data.aboutMovieViewModel)

                        if let reviewViewModels = data.reviewViewModels {
                            reviewListView(viewModels: reviewViewModels)
                        }
                    }
                    .padding(.horizontal, Constants.Description.contentInsets)
                }
            }
        }
        .scrollIndicators(.hidden)
    }

    func headerView(name: String?, rating: Double, isFavorite: Bool) -> some View {
        HStack {
            RatingTagView(style: .titleOnly(.medium), value: rating)

            Spacer()

            if let name {
                Text(name)
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
            }

            Spacer()

            FavoriteButton(isSet: isFavorite) {
                viewModel.handle(.favoriteTapped)
            }
        }
        .padding()
    }

    func posterView(_ poster: String?) -> some View {
        MovieAsyncImage(urlString: poster)
            .overlay {
                LinearGradient(
                    colors: [.background, .background.opacity(Constants.gradientEndOpacity)],
                    startPoint: .bottom,
                    endPoint: .center
                )
            }
    }

    func genreListView(genres: [String]) -> some View {
        TagLayout(spacing: Constants.genresSpacing) {
            ForEach(genres, id: \.self) { genre in
                GenreTag(name: genre, style: .body)
            }
        }
        .mediumLabeled(LocalizedKeysConstants.Content.genres)
    }

    func aboutMovieView(viewModel: AboutMovieViewModel) -> some View {
        AboutMovieView(viewModel: viewModel)
            .mediumLabeled(LocalizedKeysConstants.Content.aboutMovie)
    }

    func reviewListView(viewModels: [ReviewViewModel]) -> some View {
        VStack(alignment: .leading) {
            Text(LocalizedKeysConstants.Content.reviews)
                .font(.system(size: Constants.sectionHeaderFontSize, weight: .bold))

            VStack(spacing: Constants.reviewsSpacing) {
                ForEach(viewModels) { viewModel in
                    ReviewView(viewModel: viewModel) {

                    }
                }
            }
        }
    }
}

#Preview {
    MovieDetailsView(viewModel: .init(movieDetails: .mock))
        .environment(\.locale, .init(identifier: "ru"))
}
