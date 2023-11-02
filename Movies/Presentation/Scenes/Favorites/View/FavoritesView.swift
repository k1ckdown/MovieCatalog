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
        static let horizontalInset: CGFloat = 15
    }
}

private extension FavoritesView {

    func loadedView(itemViewModels: [MovieShortItemViewModel]) -> some View {
        ScrollView(.vertical) {
            FavoritesLayout {
                ForEach(itemViewModels) { itemViewModel in
                    MovieShortItem(viewModel: itemViewModel)
                }
            }
            .padding(.horizontal, Constants.horizontalInset)
        }
        .scrollIndicators(.hidden)
    }
}

//#Preview {
//    FavoritesView(v)
//}
