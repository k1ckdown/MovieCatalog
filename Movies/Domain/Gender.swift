//
//  Gender.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case male
    case female

    var id: String {
        rawValue
    }
}
