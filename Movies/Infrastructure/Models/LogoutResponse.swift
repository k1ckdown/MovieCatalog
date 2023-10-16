//
//  LogoutResponse.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

struct LogoutResponse: Decodable {
    let token: String
    let message: String
}
