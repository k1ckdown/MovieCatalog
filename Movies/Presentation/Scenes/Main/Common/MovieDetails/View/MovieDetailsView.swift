//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import SwiftUI

struct MovieDetailsView: View {

    @State private var tabBarVisibility = Visibility.visible
    @StateObject private var viewModel: MovieDetailsViewModel

    init(viewModel: MovieDetailsViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        contentView
            .appBackground()
            .toolbarRole(.editor)
            .toolbar(tabBarVisibility, for: .tabBar)
            .navigationBarTitleDisplayMode(.inline)
            .redacted(if: viewModel.state == .loading)
            .onAppear() {
                viewModel.handle(.onAppear)
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

        case .loading:
            detailsView(model: .placeholder())

        case .loaded(let viewData):
            loadedView(data: viewData)

        case .error(let message):
            Text(message)
        }
    }

    private var isConfirmationDialogPresented: Binding<Bool> {
        guard case .loaded(let viewData) = viewModel.state else {
            return .falseBinding
        }

        return Binding(
            get: { viewData.isConfirmationDialogPresenting },
            set: { viewModel.handle(.onConfirmationDialogPresented($0)) }
        )
    }

    private enum Constants {
        static let posterHeight: CGFloat = 560
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

        enum ReviewDialog {
            static let blur: CGFloat = 2
            static let opacity: CGFloat = 0.4
            static let horizontalInsets: CGFloat = 25
        }
    }
}

// MARK: - Loaded view

private extension MovieDetailsView {

    func loadedView(data: MovieDetailsViewState.ViewData) -> some View {
        detailsView(model: data.detailsModel)
            .disabled(data.isReviewDialogPresented)
            .opacity(data.isReviewDialogPresented ? Constants.ReviewDialog.opacity : 1)
            .blur(radius: data.isReviewDialogPresented ? Constants.ReviewDialog.blur : 0)
            .scrollIndicators(.hidden)
            .confirmationDialog("", isPresented: isConfirmationDialogPresented) {
                Button(LocalizedKey.Content.Action.edit) {
                    withAnimation {
                        viewModel.handle(.editReviewTapped)
                    }
                }

                Button(LocalizedKey.Content.Action.deleteReview, role: .destructive) {
                    viewModel.handle(.deleteReviewTapped)
                }
            }
            .overlay(alignment: .center) {
                if let reviewDialogViewModel = data.reviewDialog?.viewModel {
                    ReviewDialog(viewModel: reviewDialogViewModel, saveTappedHandler: { updatedViewModel in
                        viewModel.handle(.saveReviewTapped(updatedViewModel))
                    }, cancelTappedHandler: {
                        withAnimation {
                            viewModel.handle(.cancelReviewTapped)
                        }
                    })
                    .padding(.horizontal, Constants.ReviewDialog.horizontalInsets)
                }
            }
    }
}

// MARK: - Details view

private extension MovieDetailsView {

    func detailsView(model: MovieDetailsView.Model) -> some View {
        ScrollView(.vertical) {
            VStack(spacing: Constants.posterSpacing) {
                posterView(model.poster)

                VStack(spacing: Constants.Content.spacing) {
                    headerView(
                        name: model.name,
                        rating: model.rating,
                        isFavorite: model.isFavorite
                    )

                    ExpandableText(text: model.description)

                    VStack(alignment: .leading, spacing: Constants.detailsSpacing) {
                        genreListView(genres: model.genres)
                        aboutMovieView(viewModel: model.aboutMovieViewModel)
                        reviewListView(viewModels: model.reviewViewModels)
                    }
                }
                .padding(.horizontal, Constants.Content.horizontalInsets)
            }
        }
    }

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

    func headerView(name: String, rating: Double, isFavorite: Bool) -> some View {
        HStack {
            RatingTagView(style: .titleOnly(.medium), value: rating)

            Spacer()

            Text(name)
                .font(.title.bold())
                .multilineTextAlignment(.center)

            Spacer()

            FavoriteButton(isSet: isFavorite) {
                viewModel.handle(.favoriteTapped)
            }
        }
    }

    func genreListView(genres: [GenreViewModel]) -> some View {
        TagLayout(spacing: Constants.genresSpacing) {
            ForEach(genres) { genre in
                GenreTag(viewModel: genre)
            }
        }
        .mediumLabeled(LocalizedKey.Content.genres)
    }

    func aboutMovieView(viewModel: AboutMovieViewModel) -> some View {
        AboutMovieView(viewModel: viewModel)
            .mediumLabeled(LocalizedKey.Content.aboutMovie)
    }

    func reviewListView(viewModels: [ReviewViewModel]) -> some View {
        VStack(alignment: .leading) {
            Text(LocalizedKey.Content.reviews)
                .font(.system(size: Constants.sectionHeaderFontSize, weight: .bold))

            VStack(spacing: Constants.reviewsSpacing) {
                ForEach(viewModels) { itemViewModel in
                    ReviewView(viewModel: itemViewModel) {
                        viewModel.handle(.reviewOptionsTapped(itemViewModel.id))
                    }
                }
            }
        }
    }
}


#Preview {
    ScreenFactory(appFactory: .init())
        .makeMovieDetailsView(
            movieId: "",
            showAuthSceneHandler: {}
        )
}
