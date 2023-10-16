//
//  EndPoint.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

protocol EndPoint {
    var path: String { get }
    var component: String { get }
}
