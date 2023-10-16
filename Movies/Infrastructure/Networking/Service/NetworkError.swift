//
//  NetworkError.swift
//  Movies
//
//  Created by Ivan Semenov on 15.10.2023.
//

import Foundation

enum NetworkError: LocalizedError {
    case missingURL
    case invalidData
    case requestFailed
    case encodingError
    case decodingError
    case invalidResponse

    var errorDescription: String? {
        switch self {
        case .missingURL:
            return "URL is nil."
        case .invalidResponse:
            return "Invalid Response."
        case .invalidData:
            return "Response returned with no data to decode."
        case .decodingError:
            return "Decoding error."
        case .encodingError:
            return "Encoding error."
        case .requestFailed:
            return "Request failed. Please, try again later."
        }
    }
}
