//
//  HomeView.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        contentView
            .redacted(if: viewModel.state == .loading)
            .backgroundColor()
            .onAppear {
                viewModel.handle(.onAppear)
            }
    }

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .idle:
            EmptyView()

        case .loading:
            listView(
                cardItems: .placeholders(count: Constants.countCardPlaceholders),
                listItems: .placeholders(count: Constants.countListPlaceholders),
                loadMore: .unavailable
            )

        case .loaded(let viewData):
            listView(
                cardItems: viewData.cardItems,
                listItems: viewData.listItems,
                loadMore: viewData.loadMore
            )

        case .error(let message):
            ErrorView(message: message)
        }
    }

    private enum Constants {
        static let contentSpacing: CGFloat = 12

        static let countCardPlaceholders = 4
        static let countListPlaceholders = 3

        static let moviePageHeight: CGFloat = 497
        static let spacingMovieItems: CGFloat = 17
        static let titleVerticalInsets: CGFloat = 5
    }
}

// MARK: - List view

private extension HomeView {

    func listView(
        cardItems: [MovieDetailsItemViewModel],
        listItems: [MovieDetailsItemViewModel],
        loadMore: HomeViewState.ViewData.LoadMore
    ) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.contentSpacing) {
                tabView(cardItems)
                movieListView(
                    loadMore: loadMore,
                    itemViewModels: listItems
                )
            }
            .disabled(viewModel.state == .loading)
        }
        .scrollIndicators(.hidden)
    }
}

// MARK: - Tab view

private extension HomeView {

    func tabView(_ cardViewModel: [MovieDetailsItemViewModel]) -> some View {
        TabView {
            ForEach(cardViewModel) { cardViewModel in
                MovieAsyncImage(urlString: cardViewModel.poster, isShowingProgressView: true)
                    .onTapGesture {
                        viewModel.handle(.onSelectMovie(cardViewModel.id))
                    }
            }
            .scaledToFill()
        }
        .frame(height: Constants.moviePageHeight)
        .clipped()
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .listRowInsets(EdgeInsets())
    }
}

// MARK: - Movie list view

private extension HomeView {

    func listHeader() -> some View {
        Text(LocalizedKey.Movie.catalog)
            .bold()
            .font(.title)
            .foregroundStyle(.white)
            .padding(.vertical, Constants.titleVerticalInsets)
    }

    @ViewBuilder
    func loadMoreView(_ loadMore: HomeViewState.ViewData.LoadMore) -> some View {
        switch loadMore {
        case .available:
            ProgressView()
                .tint(.appAccent)
                .onAppear {
                    viewModel.handle(.willDisplayLastMovie)
                }

        case .failed, .unavailable:
            EmptyView()
        }
    }

    func movieListView(
        loadMore: HomeViewState.ViewData.LoadMore,
        itemViewModels: [MovieDetailsItemViewModel]
    ) -> some View {
        Group {
            listHeader()
            LazyVStack(spacing: Constants.spacingMovieItems) {
                ForEach(itemViewModels) { itemViewModel in
                    MovieDetailsItem(viewModel: itemViewModel)
                        .onTapGesture {
                            viewModel.handle(.onSelectMovie(itemViewModel.id))
                        }
                }

                loadMoreView(loadMore)
            }
            .padding(.bottom)
        }
        .padding(.horizontal)
    }
}
