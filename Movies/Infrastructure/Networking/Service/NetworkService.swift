//
//  NetworkServiec.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

final class NetworkService {

    private enum Constants {
        static let baseUrl = "https://react-midterm.kreosoft.space/api/"
    }

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
}

// MARK: - MovieNetworkService

extension NetworkService: MovieNetworkService {
    func fetchMovies(page: Int) async throws -> MoviesResponse {
        let url = try getAbsoluteURL(endPoint: MovieEndPoint.listByPage(page))
        let request = Request<MoviesResponse>(url: url, method: .get())

        return try await decode(request: request)
    }

    func fetchDetails(id: String) async throws -> MovieDetailsDTO {
        let url = try getAbsoluteURL(endPoint: MovieEndPoint.detailsById(id))
        let request = Request<MovieDetailsDTO>(url: url, method: .get())

        return try await decode(request: request)
    }
}

// MARK: - Private methods

private extension NetworkService {
    func addAuthHeader(_ headers: inout HTTPHeaders, with token: String) {
        headers["Authorization"] = "Bearer \(token)"
    }

    func getAbsoluteURL(endPoint: EndPoint) throws -> URL {
        guard let url = URL(string: Constants.baseUrl + endPoint.path + endPoint.component) else {
            throw NetworkError.missingURL
        }
        return url
    }

    func encode<Value: Encodable>(_ value: Value) throws -> Data {
        guard let encoded = try? encoder.encode(value) else {
            throw NetworkError.encodingError
        }

        return encoded
    }

    func decode<Value: Decodable>(request: Request<Value>) async throws -> Value {
        let data = try await getData(for: request)

        guard let model = try? decoder.decode(Value.self, from: data) else {
            throw NetworkError.decodingError
        }

        return model
    }

    func getData<Response: Decodable>(for request: Request<Response>) async throws -> Data {
        let urlRequest = try request.build()
        print(String(decoding: urlRequest.httpBody ?? .init(), as: UTF8.self))

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard
            let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            throw NetworkError.invalidResponse
        }

        return data
    }
}
