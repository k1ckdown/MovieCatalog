//
//  ReviewListSection.swift
//  Movies
//
//  Created by Ivan Semenov on 18.11.2023.
//

import SwiftUI

struct ReviewListSection: View {

    let viewModels: [ReviewViewModel]
    let shouldShowAddReview: Bool

    let addReviewTappedHandler: () -> Void
    let reviewOptionsTappedHandler: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.contentSpacing) {
            HStack {
                Text(LocalizedKey.Movie.reviews)
                    .font(.system(size: Constants.headerFontSize, weight: .bold))

                Spacer()

                if shouldShowAddReview {
                    Button {
                        withAnimation {
                            addReviewTappedHandler()
                        }
                    } label: {
                        Image(systemName: Constants.PlusButton.imageName)
                            .resizable()
                            .frame(width: Constants.PlusButton.size, height: Constants.PlusButton.size)
                            .foregroundStyle(.white, .appAccent)
                    }
                }
            }

            VStack(spacing: Constants.rowSpacing) {
                ForEach(viewModels) { itemViewModel in
                    ReviewView(viewModel: itemViewModel) {
                        reviewOptionsTappedHandler(itemViewModel.id)
                    }
                }
            }
        }
    }

    private enum Constants {
        static let contentSpacing: CGFloat = 20
        static let headerFontSize: CGFloat = 19
        static let rowSpacing: CGFloat = 20

        enum PlusButton {
            static let size: CGFloat = 37
            static let imageName = "plus.circle.fill"
        }
    }
}
