//
//  FavoritesView.swift
//  Movies
//
//  Created by Ivan Semenov on 01.11.2023.
//

import SwiftUI

struct FavoritesView: View {

    @StateObject private var viewModel: FavoritesViewModel

    init(viewModel: FavoritesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        contentView
            .redacted(if: viewModel.state == .loading)
            .backgroundColor()
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(LocalizedKey.TabTitle.favorites)
            .onAppear {
                viewModel.handle(.onAppear)
            }
    }

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .idle:
            EmptyView()

        case .error(let message):
            ErrorView(message: message)

        case .loading:
            collectionView(
                itemViewModels: .placeholders(
                    count: Constants.Collection.countPlaceholders
                )
            )

        case .loaded(let viewData):
            loadedView(data: viewData)
        }
    }

    private enum Constants {
        enum Collection {
            static let countPlaceholders = 3
            static let horizontalInset: CGFloat = 15
        }

        enum Placeholder {
            static let offsetY: CGFloat = 60
            static let headerLineLimit = 1
            static let contentSpacing: CGFloat = 7
            static let headerMinimumScale: CGFloat = 0.7
        }
    }
}

private extension FavoritesView {

    @ViewBuilder
    func loadedView(data: FavoritesViewState.ViewData) -> some View {
        if data.shouldShowPlaceholder {
            placeholder()
        } else {
            collectionView(itemViewModels: data.movieItems)
        }
    }

    func collectionView(itemViewModels: [MovieShortItemViewModel]) -> some View {
        ScrollView(.vertical) {
            FavoritesLayout {
                ForEach(itemViewModels) { itemViewModel in
                    MovieShortItem(viewModel: itemViewModel)
                        .onTapGesture {
                            viewModel.handle(.onSelectMovie(itemViewModel.id))
                        }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, Constants.Collection.horizontalInset)
            .disabled(viewModel.state == .loading)
        }
        .scrollIndicators(.hidden)
    }

    func placeholder() -> some View {
        VStack(spacing: Constants.Placeholder.contentSpacing) {
            Text(LocalizedKey.Movie.noFavorites)
                .font(.title3.weight(.bold))
                .lineLimit(Constants.Placeholder.headerLineLimit)
                .minimumScaleFactor(Constants.Placeholder.headerMinimumScale)

            Text(LocalizedKey.Movie.addFavorites)
                .font(.subheadline)

            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal)
        .offset(y: Constants.Placeholder.offsetY)
    }
}
