//
//  TagLayout.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import SwiftUI

struct TagLayout: Layout {

    var lineLimit: Int?
    let verticalSpacing: Double = 10
    let horizontaleSpacing: Double = 10

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let numberOfRows = Double(computeNumberOfRows(for: subviews, with: proposal.width ?? 0))
        let minHeight = subviews.map { $0.sizeThatFits(proposal).height }.reduce(0) { max($0, $1).rounded(.up) }
        let height = numberOfRows * minHeight + max(numberOfRows - 1, 0) * verticalSpacing

        return CGSize(width: proposal.width ?? 0, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var currentRow = 1
        let minHeight = subviews.map { $0.sizeThatFits(proposal).height }.reduce(0) { max($0, $1).rounded(.up) }
        var point = CGPoint(x: bounds.minX, y: bounds.minY)

        for subview in subviews.sorted(by: { $0.priority > $1.priority }) {
            let width = subview.sizeThatFits(proposal).width

            if (point.x +  width) > bounds.maxX && currentRow != lineLimit {
                point.x = bounds.minX
                point.y += minHeight + verticalSpacing

                currentRow += 1
            }

            subview.place(at: point, anchor: .topLeading, proposal: proposal)
            point.x += width + horizontaleSpacing
        }
    }

    private func computeNumberOfRows(for subviews: Subviews, with width: Double) -> Int {
        var numberOfRows = 0
        var x: Double = 0

        for subview in subviews {
            let subviewWidth = subview.sizeThatFits(.unspecified).width

            if (x + subviewWidth + horizontaleSpacing) > width {
                x = 0
                numberOfRows += 1
            }

            x += subviewWidth
        }

        if x > 0 {
            numberOfRows += 1
        }

        return numberOfRows
    }
}
