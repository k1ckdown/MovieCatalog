//
//  HomeViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class HomeViewModel: ViewModel {

    @Published private(set) var state: HomeViewState

    private var movies = [MovieDetails]()
    private let coordinator: HomeCoordinatorProtocol
    private let fetchMovieListUseCase: FetchMovieListUseCase

    init(coordinator: HomeCoordinatorProtocol, fetchMovieListUseCase: FetchMovieListUseCase) {
        self.state = .idle
        self.coordinator = coordinator
        self.fetchMovieListUseCase = fetchMovieListUseCase
    }

    func handle(_ event: HomeViewEvent) {
        switch event {
        case .onAppear:
            Task { await fetchMovies() }

        case .willDisplayLastItem:
            Task { await loadMore() }

        case .onSelectMovie(let id):
            coordinator.showMovieDetails(id)
        }
    }
}

private extension HomeViewModel {

    func loadMore() async {
        do {
            let nextMovies = try await fetchMovieListUseCase.execute(.next)
            movies.append(contentsOf: nextMovies)

            let itemViewModels = nextMovies.map { makeItemViewModel($0) }
            state = state.loadedMore(itemViewModels)
        } catch let error as MovieRepository.MovieRepositoryError {
            state = error == .maxPagesReached ? state.unavailableLoadMore() : state.failedLoadMore()
        } catch {
            state = state.failedLoadMore()
        }
    }

    func fetchMovies() async {
        state = .loading

        do {
            movies = try await fetchMovieListUseCase.execute(.first)
            let itemViewModels = movies.map { makeItemViewModel($0) }
            state = .loaded(.init(loadMore: .available, movieItems: itemViewModels))
        } catch {
            state = .error("\(error)")
        }
    }

    func makeItemViewModel(_ movie: MovieDetails) -> MovieDetailsItemViewModel {
        .init(id: movie.id,
              name: movie.name,
              year: movie.year,
              country: movie.country,
              poster: movie.poster,
              rating: movie.rating,
              userRating: movie.userRating,
              genres: movie.genres
        )
    }
}
