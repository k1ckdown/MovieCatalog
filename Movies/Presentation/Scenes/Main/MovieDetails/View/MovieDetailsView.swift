//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import SwiftUI

struct MovieDetailsView: View {

    @State private var isHeaderBarShowing = false
    @State private var tabBarVisibility = Visibility.visible

    @StateObject private var viewModel: MovieDetailsViewModel

    init(viewModel: MovieDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        contentView
            .backgroundColor()
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
            ErrorView(message: message)
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
        static let posterSpacing: CGFloat = 30
        static let genresSpacing: CGFloat = 9
        static let detailsSpacing: CGFloat = 25

        enum Content {
            static let spacing: CGFloat = 28
            static let horizontalInsets: CGFloat = 16
        }

        enum HeaderBar {
            static let lineLimit = 1
            static let minimumScaleFactor: CGFloat = 0.75
        }

        enum ReviewDialog {
            static let blur: CGFloat = 2
            static let opacity: CGFloat = 0.4
            static let horizontalInsets: CGFloat = 25
            static let backgroundOpacity: CGFloat = 0.35
        }
    }
}

private extension MovieDetailsView {

    func loadedView(data: MovieDetailsViewState.ViewData) -> some View {
        detailsView(model: data.movie)
            .disabled(data.isReviewDialogPresented)
            .opacity(data.isReviewDialogPresented ? Constants.ReviewDialog.opacity : 1)
            .blur(radius: data.isReviewDialogPresented ? Constants.ReviewDialog.blur : 0)
            .scrollIndicators(.hidden)
            .toolbar {
                if isHeaderBarShowing {
                    ToolbarItem(placement: .principal) {
                        Text(data.movie.name)
                            .font(.title2.bold())
                            .lineLimit(Constants.HeaderBar.lineLimit)
                            .minimumScaleFactor(Constants.HeaderBar.minimumScaleFactor)
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        FavoriteButton(size: .small, isSet: data.movie.isFavorite) {
                            viewModel.handle(.favoriteTapped)
                        }
                    }
                }
            }
            .confirmationDialog("", isPresented: isConfirmationDialogPresented) {
                Button(LocalizedKey.Movie.Action.edit) {
                    withAnimation {
                        viewModel.handle(.editReviewTapped)
                    }
                }

                Button(LocalizedKey.Movie.Action.deleteReview, role: .destructive) {
                    withAnimation {
                        viewModel.handle(.deleteReviewTapped)
                    }
                }
            }
            .overlay(alignment: .center) {
                if let reviewDialog = data.reviewDialog {
                    ReviewDialog(viewModel: reviewDialog) { event in
                        viewModel.handle(.reviewDialog(event))
                    }
                    .padding(.horizontal, Constants.ReviewDialog.horizontalInsets)
                    .backgroundColor(.black.opacity(Constants.ReviewDialog.backgroundOpacity))
                }
            }
    }

    func detailsView(model: MovieDetailsView.Model) -> some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(spacing: Constants.posterSpacing) {
                    MoviePosterView(
                        imageUrl: model.poster,
                        safeAreaInsetTop: geometry.safeAreaInsets.top
                    )

                    VStack(spacing: Constants.Content.spacing) {
                        MovieDetailsHeader(
                            movieName: model.name,
                            rating: model.rating,
                            isFavorite: model.isFavorite,
                            isDisappeared: $isHeaderBarShowing,
                            safeAreaInsetTop: geometry.safeAreaInsets.top
                        ) {
                            viewModel.handle(.favoriteTapped)
                        }

                        ExpandableText(text: model.description)

                        VStack(alignment: .leading, spacing: Constants.detailsSpacing) {
                            TagLayout(spacing: Constants.genresSpacing) {
                                ForEach(model.genres) { genre in
                                    GenreTag(viewModel: genre)
                                }
                            }
                            .mediumLabeled(LocalizedKey.Movie.genres)

                            AboutMovieView(viewModel: model.aboutMovieViewModel)
                                .mediumLabeled(LocalizedKey.Movie.aboutMovie)
                            
                            ReviewListSection(
                                viewModels: model.reviewViewModels,
                                shouldShowAddReview: model.shouldShowAddReview
                            ) {
                                viewModel.handle(.addReviewTapped)
                            } reviewOptionsTappedHandler: { id in
                                viewModel.handle(.reviewOptionsTapped(id))
                            }
                        }
                    }
                    .padding(.horizontal, Constants.Content.horizontalInsets)
                }
                .disabled(viewModel.state == .loading)
            }
        }
    }
}
