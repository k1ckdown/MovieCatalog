//
//  MovieLocalDataSource.swift
//  Movies
//
//  Created by Ivan Semenov on 17.11.2023.
//

import Foundation
@preconcurrency import RealmSwift

final class MovieLocalDataSource {

    private let realmProvider = RealmProvider()

    func fetchMovie(id: String) async -> MovieObject? {
        guard let storage = await realmProvider.realm() else { return nil }
        return storage.object(ofType: MovieObject.self, forPrimaryKey: id)
    }

    func fetchMovieList() async -> Results<MovieObject>? {
        guard let storage = await realmProvider.realm() else { return nil }
        return storage.objects(MovieObject.self)
    }

    func deleteAllMovies() async {
        guard let storage = await realmProvider.realm() else { return }

        storage.writeAsync {
            storage.delete(storage.objects(MovieObject.self))
        }
    }

    func deleteMovie(id: String) async {
        guard
            let storage = await realmProvider.realm(),
            let movieObject = storage.object(ofType: MovieObject.self, forPrimaryKey: id)
        else { return }

        storage.writeAsync {
            storage.delete(movieObject)
        }
    }

    func addMovie(_ movieObject: MovieObject, update: Bool = false) async {
        guard
            let storage = await realmProvider.realm(),
            !(update && storage.object(ofType: MovieObject.self, forPrimaryKey: movieObject.id) == nil)
        else { return }

        storage.writeAsync {
            storage.add(movieObject, update: .modified)
        }
    }
}
