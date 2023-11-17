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
                name: LocalizedKey.Movie.Description.year,
                value: viewModel.year
            )
            rowView(
                name: LocalizedKey.Movie.Description.country,
                value: viewModel.country
            )
            rowView(
                name: LocalizedKey.Movie.Description.tagline,
                value: viewModel.tagline
            )
            rowView(
                name: LocalizedKey.Movie.Description.director,
                value: viewModel.director
            )
            rowView(
                name: LocalizedKey.Movie.Description.budget,
                value: viewModel.budget
            )
            rowView(
                name: LocalizedKey.Movie.Description.fees,
                value: viewModel.fees
            )
            rowView(
                name: LocalizedKey.Movie.Description.ageLimit,
                value: viewModel.ageLimit
            )
            rowView(
                name: LocalizedKey.Movie.Description.time,
                value: viewModel.time
            )
        }
        .font(.system(size: Constants.fontSize))
    }

    private enum Constants {
        static let fontSize: CGFloat = 16
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
    }
}
