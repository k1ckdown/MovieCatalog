//
//  MainViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class MainViewModel: ViewModel {

    @Published private(set) var state: MainViewState
    private let movies = MockData.movies

    init() {
        self.state = .idle
    }

    func handle(_ event: MainViewEvent) {
        switch event {
        case .onAppear:
            Task { await fetchMovies() }

        case .onSelectMovie(let id):
            print(id)
        }
    }
}

private extension MainViewModel {

    func fetchMovies() async {
        state = .loading

        let itemViewModels = movies.map { makeItemViewModel($0) }
        let cardItems = Array(itemViewModels[0..<4])
        let listItems = Array(itemViewModels[4...])

        state = .loaded(.init(cardMovies: cardItems, listMovies: listItems))
    }

    func makeItemViewModel(_ movie: Movie) -> MovieItemViewModel {
        .init(id: movie.id,
              name: movie.name,
              year: movie.year,
              country: movie.country,
              poster: movie.poster,
              rating: 7.0,
              userRating: nil,
              genres: movie.genres.map { $0.name },
              shouldShowGenresEllipsis: movie.genres.count > 5
        )
    }
}
