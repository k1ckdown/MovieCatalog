//
//  UISegmentedControl+Extensions.swift
//  Movies
//
//  Created by Ivan Semenov on 20.10.2023.
//

import UIKit

extension UISegmentedControl {
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
