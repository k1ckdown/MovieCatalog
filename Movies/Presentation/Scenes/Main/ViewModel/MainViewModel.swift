//
//  MainViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class MainViewModel: ViewModel {

    @Published private(set) var state: MainViewState

    private var movies = [MovieDetails]()
    private let coordinator: MainCoordinatorProtocol
    private let fetchMoviesUseCase: FetchMoviesUseCase

    init(coordinator: MainCoordinatorProtocol, fetchMoviesUseCase: FetchMoviesUseCase) {
        self.state = .idle
        self.coordinator = coordinator
        self.fetchMoviesUseCase = fetchMoviesUseCase
    }

    func handle(_ event: MainViewEvent) {
        switch event {
        case .onAppear:
            Task { await fetchMovies() }

        case .onSelectMovie(let id):
            movieSelected(id: id)

        case .willDisplayItem(let id):
            guard id == movies.last?.id else { return }
            Task { await loadMore() }
        }
    }
}

private extension MainViewModel {

    enum Constants {
        static let numberOfCards = 4
    }

    func loadMore() async {
        do {
            let nextMovies = try await fetchMoviesUseCase.execute(.next)
            movies.append(contentsOf: nextMovies)

            let itemViewModels = movies.map { makeItemViewModel($0) }
            let cardItems = Array(itemViewModels[0..<Constants.numberOfCards])
            let listItems = Array(itemViewModels[Constants.numberOfCards...])

            state = .loaded(.init(cardMovies: cardItems, listMovies: listItems))
        } catch {
            print(error)
        }
    }

    func movieSelected(id: String) {
        guard let movie = movies.first(where: { $0.id == id }) else {
            return
        }
        coordinator.showMovieDetails(movie)
    }

    func fetchMovies() async {
        state = .loading

        do {
            movies = try await fetchMoviesUseCase.execute(.first)
            let itemViewModels = movies.map { makeItemViewModel($0) }

            let cardItems = Array(itemViewModels[0..<Constants.numberOfCards])
            let listItems = Array(itemViewModels[Constants.numberOfCards...])

            state = .loaded(.init(cardMovies: cardItems, listMovies: listItems))
        } catch {
            state = .error("\(error)")
        }
    }

    func makeItemViewModel(_ movie: MovieDetails) -> MovieDetailsItemViewModel {
        let genres = movie.genres ?? []
        let notAvailable = LocalizedKeysConstants.Content.notAvailable

        return .init(id: movie.id,
                     name: movie.name ?? notAvailable,
                     year: movie.year,
                     country: movie.country ?? notAvailable,
                     poster: movie.poster,
                     rating: movie.rating,
                     userRating: movie.userRating,
                     genres: genres.compactMap { $0.name },
                     shouldShowGenresEllipsis: genres.count > 5
        )
    }
}
