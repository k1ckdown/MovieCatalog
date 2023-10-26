//
//  HTTPTask.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

typealias Parameters = [String: Any]

enum HTTPTask {
    case request
    case requestBody(Data)
    case requestUrlParameters(Parameters)
}
