//
//  String+Placeholder.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

extension String {
    static func placeholder(length: Int) -> String {
        return String(Array(repeating: "X", count: length))
    }
}
