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
            static let height: CGFloat = 285
        }

        enum Medium {
            static let width: CGFloat = 360
            static let height: CGFloat = 235
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

private extension FavoritesLayout {

    func maxSize(subviews: Subviews, proposal: ProposedViewSize) -> CGSize {
        let numberViews = subviews.count

        let numberMediumViews = numberViews / 3
        let numberSmallViews = Double(numberViews - numberMediumViews)

        let numberRowsSmallViews = Int((numberSmallViews / 2.0).rounded(.up))
        let numberOfRows = numberMediumViews + numberRowsSmallViews

        let heightOfRowsSmallViews = CGFloat(numberRowsSmallViews) * Constants.Small.height
        let heightOfMediumViews = CGFloat(numberMediumViews) * Constants.Medium.height

        let heightOfRows = heightOfMediumViews + heightOfRowsSmallViews
        let totalHeight = heightOfRows + CGFloat((numberOfRows - 1)) * Constants.Spacing.vertical

        return .init(width: proposal.width ?? 0, height: totalHeight)
    }
}
