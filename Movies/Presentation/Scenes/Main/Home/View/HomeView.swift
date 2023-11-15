//
//  HomeView.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject private(set) var viewModel: HomeViewModel

    var body: some View {
        ZStack {
            contentView
        }
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
                movieItems: .placeholders(count: Constants.countPlaceholders),
                loadMore: .unavailable
            )

        case .loaded(let viewData):
            listView(
                movieItems: viewData.movieItems,
                loadMore: viewData.loadMore
            )

        case .error(let message):
            Text(message)
        }
    }

    private enum Constants {
        static let contentSpacing: CGFloat = 12

        static let numberOfCards = 4
        static let countPlaceholders = numberOfCards + 2

        static let moviePageHeight: CGFloat = 497
        static let spacingMovieItems: CGFloat = 17
        static let titleVerticalInsets: CGFloat = 5
    }
}

// MARK: - List view

private extension HomeView {

    func listView(
        movieItems: [MovieDetailsItemViewModel],
        loadMore: HomeViewState.ViewData.LoadMore
    ) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.contentSpacing) {
                tabView(Array(movieItems[0..<Constants.numberOfCards]))
                movieListView(
                    loadMore: loadMore,
                    itemViewModels: Array(movieItems[Constants.numberOfCards...])
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
        Text(LocalizedKey.Content.catalog)
            .bold()
            .font(.title)
            .foregroundStyle(.white)
            .padding(.vertical, Constants.titleVerticalInsets)
    }

    @ViewBuilder
    private func loadMoreView(_ loadMore: HomeViewState.ViewData.LoadMore) -> some View {
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

#Preview {
    ScreenFactory(appFactory: .init()).makeHomeView(coordinator: HomeCoordinator(showAuthSceneHandler: {}))
}
