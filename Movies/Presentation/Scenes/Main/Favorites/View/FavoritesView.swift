//
//  FavoritesView.swift
//  Movies
//
//  Created by Ivan Semenov on 01.11.2023.
//

import SwiftUI

struct FavoritesView: View {

    @ObservedObject private(set) var viewModel: FavoritesViewModel

    var body: some View {
        contentView
            .appBackground()
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(LocalizedKeysConstants.ScreenTitle.favorites)
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
            ProgressView()
        case .error(let message):
            Text(message)
        case .loaded(let viewData):
            loadedView(itemViewModels: viewData.movieItems)
        }
    }

    private enum Constants {
        enum Collection {
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
    func loadedView(itemViewModels: [MovieShortItemViewModel]) -> some View {
        if itemViewModels.count > 0 {
            ScrollView(.vertical) {
                FavoritesLayout {
                    ForEach(itemViewModels) { itemViewModel in
                        MovieShortItem(viewModel: itemViewModel)
                    }
                }
                .padding(.vertical)
                .padding(.horizontal, Constants.Collection.horizontalInset)
            }
            .scrollIndicators(.hidden)
        } else {
            placeholder()
        }
    }

    func placeholder() -> some View {
        VStack(spacing: Constants.Placeholder.contentSpacing) {
            Text(LocalizedKeysConstants.Content.noFavorites)
                .font(.title3.weight(.bold))
                .lineLimit(Constants.Placeholder.headerLineLimit)
                .minimumScaleFactor(Constants.Placeholder.headerMinimumScale)

            Text(LocalizedKeysConstants.Content.addFavorites)
                .font(.subheadline)

            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal)
        .offset(y: Constants.Placeholder.offsetY)
    }
}

//#Preview {
//    NavigationStack {
//        FavoritesView(viewModel: .init(fetchFavoriteMoviesUseCase: AppFactory().makeFetchFavoriteMoviesUseCase()))
//            .environment(\.locale, .init(identifier: "ru"))
//    }
//}
