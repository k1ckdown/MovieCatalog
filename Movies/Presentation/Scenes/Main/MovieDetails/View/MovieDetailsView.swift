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

    private struct HeaderRectPreferenceKey: PreferenceKey {
        typealias Value = CGRect

        static var defaultValue = CGRect.zero

        static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
            value = nextValue()
        }
    }

    private enum Constants {
        static let posterHeight: CGFloat = 520
        static let gradientEndOpacity: CGFloat = 0

        static let reviewSectionSpacing: CGFloat = 20
        static let sectionHeaderFontSize: CGFloat = 19

        static let posterSpacing: CGFloat = 30
        static let genresSpacing: CGFloat = 9
        static let reviewsSpacing: CGFloat = 20
        static let detailsSpacing: CGFloat = 25

        enum Content {
            static let spacing: CGFloat = 28
            static let horizontalInsets: CGFloat = 16
        }

        enum Header {
            static let lineLimit = 4
            static let barLineLimit = 1
            static let minimumScaleFactor: CGFloat = 0.75
        }

        enum PlusButton {
            static let size: CGFloat = 37
            static let imageName = "plus.circle.fill"
        }

        enum ReviewDialog {
            static let blur: CGFloat = 2
            static let opacity: CGFloat = 0.4
            static let horizontalInsets: CGFloat = 25
            static let backgroundOpacity: CGFloat = 0.35
        }
    }
}

// MARK: - Loaded view

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
                            .lineLimit(Constants.Header.barLineLimit)
                            .minimumScaleFactor(Constants.Header.minimumScaleFactor)
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        favoriteButton(.small, isSet: data.movie.isFavorite)
                    }
                }
            }
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
                if let reviewDialog = data.reviewDialog {
                    ReviewDialog(viewModel: reviewDialog) { event in
                        viewModel.handle(.reviewDialog(event))
                    }
                    .padding(.horizontal, Constants.ReviewDialog.horizontalInsets)
                    .backgroundColor(.black.opacity(Constants.ReviewDialog.backgroundOpacity))
                }
            }
    }
}

// MARK: - Details view

private extension MovieDetailsView {

    func detailsView(model: MovieDetailsView.Model) -> some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(spacing: Constants.posterSpacing) {
                    posterView(model.poster)
                        .overlay { GeometryReader { geometry in
                            Color.background
                                .opacity(1 - Double(geometry.frame(in: .global).maxY
                                                    / (Constants.posterHeight + geometry.safeAreaInsets.top)))
                        }}

                    VStack(spacing: Constants.Content.spacing) {
                        headerView(
                            name: model.name,
                            rating: model.rating,
                            isFavorite: model.isFavorite
                        )
                        .onPreferenceChange(HeaderRectPreferenceKey.self) { value in
                            isHeaderBarShowing = value.maxY <= geometry.safeAreaInsets.top
                        }

                        ExpandableText(text: model.description)

                        VStack(alignment: .leading, spacing: Constants.detailsSpacing) {
                            genreListView(genres: model.genres)
                            aboutMovieView(viewModel: model.aboutMovieViewModel)
                            reviewListView(
                                viewModels: model.reviewViewModels,
                                shouldShowAddReview: model.userHasReview == false
                            )
                        }
                    }
                    .padding(.horizontal, Constants.Content.horizontalInsets)
                }
                .disabled(viewModel.state == .loading)
            }
        }
    }

    func posterView(_ poster: String?) -> some View {
        MovieAsyncImage(urlString: poster, isShowingProgressView: true)
            .scaledToFill()
            .frame(height: Constants.posterHeight)
            .clipped()
            .overlay {
                LinearGradient(
                    colors: [.background, .background.opacity(Constants.gradientEndOpacity)],
                    startPoint: .bottom,
                    endPoint: .center
                )
            }
    }

    func favoriteButton(_ size: FavoriteButton.Size, isSet: Bool) -> some View {
        FavoriteButton(size: size, isSet: isSet) {
            viewModel.handle(.favoriteTapped)
        }
    }

    func headerView(name: String, rating: Double, isFavorite: Bool) -> some View {
        HStack {
            RatingTagView(style: .titleOnly(.medium), value: rating)

            Spacer()

            Text(name)
                .font(.title.bold())
                .multilineTextAlignment(.center)
                .lineLimit(Constants.Header.lineLimit)
                .minimumScaleFactor(Constants.Header.minimumScaleFactor)
                .background(GeometryReader { geometry in
                    Color.clear.preference(
                        key: HeaderRectPreferenceKey.self,
                        value: geometry.frame(in: .global)
                    )
                })

            Spacer()

            favoriteButton(.medium, isSet: isFavorite)
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

    func reviewListView(viewModels: [ReviewViewModel], shouldShowAddReview: Bool) -> some View {
        VStack(alignment: .leading, spacing: Constants.reviewSectionSpacing) {
            HStack {
                Text(LocalizedKey.Content.reviews)
                    .font(.system(size: Constants.sectionHeaderFontSize, weight: .bold))

                Spacer()

                if shouldShowAddReview {
                    Button {
                        withAnimation {
                            viewModel.handle(.addReviewTapped)
                        }
                    } label: {
                        Image(systemName: Constants.PlusButton.imageName)
                            .resizable()
                            .frame(width: Constants.PlusButton.size, height: Constants.PlusButton.size)
                            .foregroundStyle(.white, .appAccent)
                    }
                }
            }

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
