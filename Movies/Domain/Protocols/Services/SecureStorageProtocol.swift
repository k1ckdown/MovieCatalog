//
//  SecureStorageProtocol.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

protocol SecureStorageProtocol {
    func saveToken(_ token: String) throws
    func updateToken(_ newToken: String) throws
    func retrieveToken() throws -> String
}
