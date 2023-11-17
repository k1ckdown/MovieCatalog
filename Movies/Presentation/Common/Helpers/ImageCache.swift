//
//  ImageCache.swift
//  Movies
//
//  Created by Ivan Semenov on 09.11.2023.
//

import SwiftUI

@MainActor
final class ImageCache {
    static private var cache = [URL: Image]()
    static subscript(url: URL?) -> Image? {
        get {
            guard let url else { return nil }
            return cache[url]
        }
        set {
            guard let url else { return }
            cache[url] = newValue
        }
    }
}
