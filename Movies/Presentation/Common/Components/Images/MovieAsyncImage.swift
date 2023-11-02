//
//  MovieAsyncImage.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import SwiftUI

struct MovieAsyncImage: View {

    let urlString: String?
    let shouldShowProgressView: Bool

    init(urlString: String?, isShowingProgressView: Bool = false) {
        self.urlString = urlString
        self.shouldShowProgressView = isShowingProgressView
    }

    var body: some View {
        AsyncImage(
            url: URL(string: urlString ?? ""),
            transaction: .init(animation: .easeInOut)
        ) { phase in
            switch phase {
            case .empty:
                if shouldShowProgressView {
                    ProgressView()
                        .tint(.appAccent)
                } else {
                    placeholder
                }

            case .success(let image):
                image
                    .resizable()
                    .transition(.scale(scale: Constants.scale, anchor: .center))

            case .failure:
                placeholder

            @unknown default:
                EmptyView()
            }
        }
    }

    private var placeholder: some View {
        Image(.moviePlaceholder)
            .resizable()
            .scaledToFill()
    }

    private enum Constants {
        static let scale = 0.1
    }
}
