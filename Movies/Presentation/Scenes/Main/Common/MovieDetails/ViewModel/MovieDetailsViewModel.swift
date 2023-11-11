//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class MovieDetailsViewModel: ViewModel {

    @Published private(set) var state: MovieDetailsViewState

    private let movieId: String
    private let router: MovieDetailsRouter

    private let fetchMovieUseCase: FetchMovieUseCase
    private let addFavoriteMovieUseCase: AddFavoriteMovieUseCase
    private let deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase

    init(
        movieId: String,
        router: MovieDetailsRouter,
        fetchMovieUseCase: FetchMovieUseCase,
        addFavoriteMovieUseCase: AddFavoriteMovieUseCase,
        deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase
    ) {
        state = .idle
        self.movieId = movieId
        self.router = router
        self.fetchMovieUseCase = fetchMovieUseCase
        self.addFavoriteMovieUseCase = addFavoriteMovieUseCase
        self.deleteFavoriteMovieUseCase = deleteFavoriteMovieUseCase
    }

    func handle(_ event: MovieDetailsViewEvent) {
        switch event {
        case .onAppear:
            Task { await retrieveMovie() }

        case .favoriteTapped:
            state = state.toggleFavorite()
            Task { await favoriteToggled() }

        case .onDialogPresented(let isPresented):
            state = state.confirmationDialog(isPresented: isPresented)

        case .reviewOptionsTapped:
            state = state.confirmationDialog(isPresented: true)

        default: break
        }
    }
}

private extension MovieDetailsViewModel {

    func retrieveMovie() async {
        state = .loading

        do {
//            let movie = try await fetchMovieUseCase.execute(movieId: movieId)
            state = .loaded(getViewData(for: MovieDetails.mock))
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    func favoriteToggled() async {
        guard case .loaded(let viewData) = state else { return }

        do {
            try await viewData.isFavorite ?
            addFavoriteMovieUseCase.execute(movieId) :
            deleteFavoriteMovieUseCase.execute(movieId)
        } catch {
            print(error.localizedDescription)
        }
    }

    func getViewData(for movie: MovieDetails) -> MovieDetailsViewState.ViewData {
        let aboutMovieViewModel = makeAboutMovieViewModel(movie)
        let reviewViewModels = movie.reviews?.compactMap { makeReviewViewModel($0) }
        let genreViewModels = makeGenreViewModels(movie.genres ?? [])

        let model = MovieDetailsView.Model(
            name: movie.name ?? LocalizedKey.Content.notAvailable,
            rating: movie.rating,
            poster: movie.poster,
            genres: genreViewModels,
            description: movie.description ?? LocalizedKey.Content.notAvailable,
            reviewViewModels: reviewViewModels ?? [],
            aboutMovieViewModel: aboutMovieViewModel
        )

        return .init(isFavorite: movie.isFavorite, model: model)
    }
    
    func makeGenreViewModels(_ genres: [Genre]) -> [GenreViewModel] {
        genres.compactMap { genre in
            guard let name = genre.name else { return nil }
            return .init(id: genre.id, name: name, style: .body)
        }
    }

    func makeReviewViewModel(_ review: ReviewDetails) -> ReviewViewModel {
        .init(
            id: review.id,
            rating: review.rating,
            isUserReview: review.isUserReview,
            reviewText: review.reviewText,
            createDateTime: review.createDateTime,
            authorNickname: review.author?.nickName,
            authorAvatarLink: review.author?.avatar
        )
    }

    func makeAboutMovieViewModel(_ movie: MovieDetails) -> AboutMovieViewModel {
        .init(
            year: movie.year,
            country: movie.country,
            tagline: movie.tagline,
            director: movie.director,
            budget: movie.budget,
            fees: movie.fees,
            ageLimit: movie.ageLimit,
            time: movie.time
        )
    }
}
