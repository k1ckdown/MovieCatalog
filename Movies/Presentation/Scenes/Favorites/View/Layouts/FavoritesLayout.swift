//
//  FavoritesLayout.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import SwiftUI

struct FavoritesLayout: Layout {

    private enum Constants {
        enum Spacing {
            static let vertical: CGFloat = 25
            static let horizontal: CGFloat = 10
        }

        enum Small {
            static let width: CGFloat = 180
            static let height: CGFloat = 270
        }

        enum Medium {
            static let width: CGFloat = 360
            static let height: CGFloat = 220
        }
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        return maxSize(subviews: subviews, proposal: proposal)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX
        var y = bounds.minY
        let width = bounds.width

        let smallWidth = (width - Constants.Spacing.horizontal) / 2
        let smallSize = ProposedViewSize(width: smallWidth, height: Constants.Small.height)
        let mediumSize = ProposedViewSize(width: width, height: Constants.Medium.height)

        for index in subviews.indices {
            switch (index + 1) % 3 {
            case 1:
                subviews[index].place(at: .init(x: x, y: y), proposal: smallSize)
                x += Constants.Small.width + Constants.Spacing.horizontal

            case 2:
                subviews[index].place(at: .init(x: x, y: y), proposal: smallSize)
                y += Constants.Small.height + Constants.Spacing.vertical
                x = bounds.minX

            case 0:
                subviews[index].place(at: .init(x: x, y: y), proposal: mediumSize)
                y += Constants.Medium.height + Constants.Spacing.vertical
                x = bounds.minX

            default: break
            }
        }
    }
}

extension FavoritesLayout {

    private func maxSize(subviews: Subviews, proposal: ProposedViewSize) -> CGSize {
        let numberViews = CGFloat(subviews.count)
        let numberMediumViews: CGFloat = numberViews / 3
        let numberSmallViews = ((numberViews - numberMediumViews) / 2).rounded(.up)

        let heightOfSmallViews = numberSmallViews * (Constants.Small.height + Constants.Spacing.vertical)
        let heightOfMediumViews = numberMediumViews * (Constants.Medium.height + Constants.Spacing.vertical)
        let maxHeight = heightOfSmallViews + heightOfMediumViews - Constants.Spacing.vertical

        return .init(width: proposal.width ?? 0, height: maxHeight)
    }
}
