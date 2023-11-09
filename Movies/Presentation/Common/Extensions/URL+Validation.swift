//
//  URL+Validation.swift
//  Movies
//
//  Created by Ivan Semenov on 09.11.2023.
//

import Foundation

extension URL {
    enum Constants {
        static let imageFormats = ["jpg", "png", "gif", "svg", "webp"]
    }

    func isImageType() -> Bool {
        self.scheme != nil &&
        self.host() != nil &&
        Constants.imageFormats.contains(self.pathExtension.lowercased())
    }
}
