//
//  URL+Validation.swift
//  Movies
//
//  Created by Ivan Semenov on 09.11.2023.
//

import UIKit

extension URL {
    enum Constants {
        static let imageFormats = ["jpg", "png", "gif", "svg", "webp"]
    }

    @MainActor func isImageType() -> Bool {
        UIApplication.shared.canOpenURL(self) &&
        Constants.imageFormats.contains(self.pathExtension.lowercased())
    }
}
