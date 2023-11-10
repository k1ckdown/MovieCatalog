//
//  AboutMovieView.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import SwiftUI

struct AboutMovieView: View {

    let viewModel: AboutMovieViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.contentSpacing) {
            rowView(
                name: LocalizedKeysConstants.Content.Description.year,
                value: "\(viewModel.year)"
            )
            rowView(
                name: LocalizedKeysConstants.Content.Description.country,
                value: viewModel.country
            )
            rowView(
                name: LocalizedKeysConstants.Content.Description.tagline,
                value: viewModel.tagline
            )
            rowView(
                name: LocalizedKeysConstants.Content.Description.director,
                value: viewModel.director
            )
            rowView(
                name: LocalizedKeysConstants.Content.Description.budget,
                value: viewModel.budget
            )
            rowView(
                name: LocalizedKeysConstants.Content.Description.fees,
                value: viewModel.fees
            )
            rowView(
                name: LocalizedKeysConstants.Content.Description.ageLimit,
                value: "\(viewModel.ageLimit)+"
            )
            rowView(
                name: LocalizedKeysConstants.Content.Description.time,
                value: "\(viewModel.time) мин."
            )
        }
    }

    private enum Constants {
        static let contentSpacing: CGFloat = 11
        static let nameLabelWidth: CGFloat = 115
    }

    private func rowView(name: String, value: String) -> some View {
        HStack {
            Text(LocalizedStringKey(name))
                .foregroundStyle(.secondary)
                .frame(width: Constants.nameLabelWidth, alignment: .leading)

            Text(value)
        }
        .font(.callout)
    }
}
