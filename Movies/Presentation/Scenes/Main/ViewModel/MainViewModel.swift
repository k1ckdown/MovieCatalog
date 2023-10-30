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
    private let fetchMoviesUseCase: FetchMoviesUseCase = AppFactory().makeFetchMoviesUseCase()

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

    enum Constants {
        static let numberOfCards = 4
    }

    func fetchMovies() async {
        state = .loading

        do {
            let movies = try await fetchMoviesUseCase.execute(.first)
            let itemViewModels = movies.map { makeItemViewModel($0) }

            let cardItems = Array(itemViewModels[0..<Constants.numberOfCards])
            let listItems = Array(itemViewModels[Constants.numberOfCards...])

            state = .loaded(.init(cardMovies: cardItems, listMovies: listItems))
        } catch {
            state = .error("\(error)")
        }
    }

    func makeItemViewModel(_ movie: MovieDetails) -> MovieItemViewModel {
        let genres = movie.genres ?? []
        let notAvailable = LocalizedKeysConstants.Content.notAvailable

        return .init(id: movie.id,
                     name: movie.name ?? notAvailable,
                     year: movie.year,
                     country: movie.country ?? notAvailable,
                     poster: movie.poster ?? "",
                     rating: movie.rating,
                     userRating: movie.userRating,
                     genres: genres.compactMap { $0.name },
                     shouldShowGenresEllipsis: genres.count > 5
        )
    }
}
