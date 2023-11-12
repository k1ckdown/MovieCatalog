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
            state = .loading
            Task { await retrieveMovie() }

        case .favoriteTapped:
            state = state.toggleFavorite()
            Task { await favoriteToggled() }

        case .reviewOptionsTapped(let reviewId):
            state = state.reviewSelected(id: reviewId)

        case .onConfirmationDialogPresented(let isPresented):
            state = state.confirmationDialog(isPresented: isPresented)

        case .editReviewTapped:
            state = state.editReview()

        case .reviewDialogSentEvent(let reviewDialogEvent):
            handleReviewDialogEvent(reviewDialogEvent)

        case .addReviewTapped:
            state = state.addReview()

        case .deleteReviewTapped:
            break
        }
    }
}

private extension MovieDetailsViewModel {

    func retrieveMovie() async {
        do {
            let movie = try await fetchMovieUseCase.execute(movieId: movieId)
            state = .loaded(getViewData(for: movie))
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    func favoriteToggled() async {
        guard case .loaded(let viewData) = state else { return }

        do {
            try await viewData.movie.isFavorite
            ? addFavoriteMovieUseCase.execute(movieId)
            : deleteFavoriteMovieUseCase.execute(movieId)
        } catch {
            print(error.localizedDescription)
        }
    }

    func handleReviewDialogEvent(_ event: ReviewDialogViewEvent) {
        switch event {
        case .saveTapped:
            state = state.reviewLoading()
            Task { await retrieveMovie() }

        case .cancelTapped:
            state = state.cancelReviewEditing()

        case .isAnonymous(let value):
            state = state.isAnonymous(value)

        case .ratingChanged(let rating):
            state = state.updateRating(rating)

        case .reviewTextChanged(let text):
            state = state.updateReviewText(text)
        }
    }
}

// MARK: - View data

private extension MovieDetailsViewModel {

    func makeGenreViewModels(_ genres: [Genre]) -> [GenreViewModel] {
        genres.compactMap { genre in
            guard let name = genre.name else { return nil }
            return .init(id: genre.id, name: name, style: .body)
        }
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

    func makeReviewViewModel(_ review: ReviewDetails) -> ReviewViewModel {
        .init(
            id: review.id,
            rating: review.rating,
            isAnonymous: review.isAnonymous,
            isUserReview: review.isUserReview,
            reviewText: review.reviewText,
            createDateTime: review.createDateTime,
            authorNickname: review.author?.nickName,
            authorAvatarLink: review.author?.avatar
        )
    }

    func getViewData(for movie: MovieDetails) -> MovieDetailsViewState.ViewData {
        let aboutMovieViewModel = makeAboutMovieViewModel(movie)
        let reviewViewModels = movie.reviews?.compactMap { makeReviewViewModel($0) }
        let genreViewModels = makeGenreViewModels(movie.genres ?? [])
        
        let model = MovieDetailsView.Model(
            name: movie.name ?? LocalizedKey.Content.notAvailable,
            rating: movie.rating,
            poster: movie.poster,
            isFavorite: movie.isFavorite,
            userHasReview: movie.userRating != nil,
            description: movie.description ?? LocalizedKey.Content.notAvailable,
            genres: genreViewModels,
            reviewViewModels: reviewViewModels ?? [],
            aboutMovieViewModel: aboutMovieViewModel
        )

        return .init(movie: model)
    }
}
