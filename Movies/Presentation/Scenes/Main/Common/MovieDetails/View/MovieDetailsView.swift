//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import SwiftUI

struct MovieDetailsView: View {

    @ObservedObject private(set) var viewModel: MovieDetailsViewModel
    @State private var tabBarVisibility = Visibility.visible

    var body: some View {
        contentView
            .appBackground()
            .toolbarRole(.editor)
            .toolbar(tabBarVisibility, for: .tabBar)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear() {
                withAnimation(.spring) {
                    tabBarVisibility = .hidden
                }
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
        static let posterHeight: CGFloat = 515
        static let gradientEndOpacity: CGFloat = 0
        static let sectionHeaderFontSize: CGFloat = 18

        static let posterSpacing: CGFloat = 30
        static let genresSpacing: CGFloat = 9
        static let reviewsSpacing: CGFloat = 18
        static let detailsSpacing: CGFloat = 25

        enum Content {
            static let spacing: CGFloat = 28
            static let horizontalInsets: CGFloat = 18
        }
    }
}

private extension MovieDetailsView {

    func detailsView(data: MovieDetailsViewState.ViewData) -> some View {
        ScrollView(.vertical) {
            VStack(spacing: Constants.posterSpacing) {
                posterView(data.poster)

                VStack(spacing: Constants.Content.spacing) {
                    headerView(name: data.name, rating: data.rating, isFavorite: data.isFavorite)

                    if let description = data.description {
                        ExpandableText(text: description)
                    }

                    VStack(alignment: .leading, spacing: Constants.detailsSpacing) {

                        if let genres = data.genres {
                            genreListView(genres: genres)
                        }

                        aboutMovieView(viewModel: data.aboutMovieViewModel)

                        if let reviewViewModels = data.reviewViewModels {
                            reviewListView(viewModels: reviewViewModels)
                        }
                    }
                }
                .padding(.horizontal, Constants.Content.horizontalInsets)
            }
        }
        .scrollIndicators(.hidden)
    }
}

private extension MovieDetailsView {

    func posterView(_ poster: String?) -> some View {
        MovieAsyncImage(urlString: poster, isShowingProgressView: true)
            .frame(height: Constants.posterHeight)
            .overlay {
                LinearGradient(
                    colors: [.background, .background.opacity(Constants.gradientEndOpacity)],
                    startPoint: .bottom,
                    endPoint: .center
                )
            }
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
    }
}

private extension MovieDetailsView {

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
