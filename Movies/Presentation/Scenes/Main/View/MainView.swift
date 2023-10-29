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
            .onAppear {
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
                cardItems: .placeholders(count: Constants.countCardPlaceholders),
                listItems: .placeholders(count: Constants.countItemPlaceholders)
            )

        case .loaded(let viewData):
            listView(
                cardItems: viewData.cardMovies,
                listItems: viewData.listMovies
            )

        case .error(let message):
            Text(message)
        }
    }

    private enum Constants {
        static let countCardPlaceholders = 1
        static let countItemPlaceholders = 6

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

private extension MainView {

    func emptyView() -> some View {
        ZStack {
            EmptyView()
        }
    }

    func listView(cardItems: [MovieItemViewModel], listItems: [MovieItemViewModel]) -> some View {
        List {
            Group {
                TabView {
                    ForEach(cardItems) { item in
                        MovieAsyncImage(imageUrl: item.poster)
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

                ForEach(listItems) { item in
                    MovieItem(viewModel: item)
                }
                .listRowInsets(Constants.ListItem.insets)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    MainView(viewModel: .init())
}