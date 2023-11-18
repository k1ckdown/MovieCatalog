//
//  MovieDetailsHeader.swift
//  Movies
//
//  Created by Ivan Semenov on 18.11.2023.
//

import SwiftUI

struct MovieDetailsHeader: View {

    let movieName: String
    let rating: Double
    let isFavorite: Bool

    @Binding var isDisappeared: Bool
    let safeAreaInsetTop: CGFloat
    let favoriteTapped: () -> Void

    var body: some View {
        HStack {
            RatingTagView(style: .titleOnly(.medium), value: rating)

            Spacer()

            Text(movieName)
                .font(.title.bold())
                .multilineTextAlignment(.center)
                .lineLimit(Constants.lineLimit)
                .minimumScaleFactor(Constants.minimumScaleFactor)
                .background(GeometryReader { geometry in
                    Color.clear.preference(
                        key: RectPreferenceKey.self,
                        value: geometry.frame(in: .global)
                    )
                })

            Spacer()

            FavoriteButton(size: .medium, isSet: isFavorite) {
                favoriteTapped()
            }
        }
        .onPreferenceChange(RectPreferenceKey.self) { value in
            isDisappeared = value.maxY <= safeAreaInsetTop
        }
    }

    private struct RectPreferenceKey: PreferenceKey {
        typealias Value = CGRect

        static var defaultValue = CGRect.zero

        static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
            value = nextValue()
        }
    }

    private enum Constants {
        static let lineLimit = 4
        static let minimumScaleFactor: CGFloat = 0.75
    }
}
