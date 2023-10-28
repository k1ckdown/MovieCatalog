//
//  GenreItem.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import SwiftUI

struct GenreItem: View {

    let name: String

    var body: some View {
        Text(name)
            .padding(.vertical, Constants.verticalInsets)
            .padding(.horizontal, Constants.horizontalInsets)
            .background(.pebble)
            .clipShape(.rect(cornerRadius: Constants.cornerRadius))
    }

    private enum Constants {
        static let cornerRadius: CGFloat = 5
        static let verticalInsets: CGFloat = 3
        static let horizontalInsets: CGFloat = 8
    }
}
