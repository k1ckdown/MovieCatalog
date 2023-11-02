//
//  MainView.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import SwiftUI

struct MainView: View {

    @ObservedObject private(set) var viewModel: MainViewModel

    var body: some View {
        contentView
            .redacted(if: viewModel.state == .loading)
            .appBackground()
            .firstAppear {
                viewModel.handle(.onAppear)
            }
    }

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .idle:
            emptyView()

        case .loading:
            listView(
                cardItems: .placeholders(count: Constants.Placeholder.countCard),
                listItems: .placeholders(count: Constants.Placeholder.countItem),
                loadMore: .unavailable
            )

        case .loaded(let viewData):
            listView(
                cardItems: viewData.cardMovies,
                listItems: viewData.listMovies,
                loadMore: viewData.loadMore
            )

        case .error(let message):
            Text(message)
        }
    }

    private enum Constants {
        static let moviePageHeight: CGFloat = 515
        static let progressViewHeight: CGFloat = 40
        static let titleVerticalInsets: CGFloat = 5
        static let listItemInsets = EdgeInsets(
            top: 0,
            leading: 15,
            bottom: 15,
            trailing: 15
        )

        enum Placeholder {
            static let countCard = 1
            static let countItem = 6
        }
    }
}

private extension MainView {

    func emptyView() -> some View {
        ZStack {
            EmptyView()
        }
    }

    func listView(
        cardItems: [MovieDetailsItemViewModel],
        listItems: [MovieDetailsItemViewModel],
        loadMore: MainViewState.ViewData.LoadMore
    ) -> some View {
        List {
            Group {
                tabView(cardItems)
                listHeader()
                movieListView(itemViewModels: listItems)
                loadMoreView(loadMore)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
    }
}

private extension MainView {

    func tabView(_ cardViewModel: [MovieDetailsItemViewModel]) -> some View {
        TabView {
            ForEach(cardViewModel) { cardViewModel in
                MovieAsyncImage(urlString: cardViewModel.poster, isShowingProgressView: true)
                    .onTapGesture {
                        viewModel.handle(.onSelectMovie(cardViewModel.id))
                    }
            }
        }
        .frame(height: Constants.moviePageHeight)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .listRowInsets(EdgeInsets())
    }

    func listHeader() -> some View {
        Text(LocalizedKeysConstants.Content.catalog)
            .bold()
            .font(.title)
            .foregroundStyle(.white)
            .padding(.vertical, Constants.titleVerticalInsets)
    }

    func movieListView(itemViewModels: [MovieDetailsItemViewModel]) -> some View {
        ForEach(itemViewModels) { itemViewModel in
            MovieDetailsItem(viewModel: itemViewModel)
                .onTapGesture {
                    viewModel.handle(.onSelectMovie(itemViewModel.id))
                }
        }
        .listRowInsets(Constants.listItemInsets)
    }

    @ViewBuilder
    private func loadMoreView(_ loadMore: MainViewState.ViewData.LoadMore) -> some View {
        switch loadMore {
        case .available:
            ProgressView()
                .frame(height: Constants.progressViewHeight)
                .frame(maxWidth: .infinity)
                .tint(.appAccent)
                .onAppear {
                    viewModel.handle(.willDisplayLastItem)
                }

        case .failed, .unavailable:
            EmptyView()
        }
    }
}

#Preview {
    MainView(
        viewModel: .init(
            coordinator: MainCoordinator(),
            fetchMoviesUseCase: AppFactory().makeFetchMoviesUseCase()
        )
    )
}
