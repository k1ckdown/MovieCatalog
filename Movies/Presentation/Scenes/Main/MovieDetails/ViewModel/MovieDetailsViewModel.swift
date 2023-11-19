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

    private let addReviewUseCase: AddReviewUseCase
    private let updateReviewUseCase: UpdateReviewUseCase
    private let deleteReviewUseCase: DeleteReviewUseCase

    private let fetchMovieUseCase: FetchMovieUseCase
    private let getMovieDetailsUseCase: GetMovieDetailsUseCase
    private let addFavoriteMovieUseCase: AddFavoriteMovieUseCase
    private let deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase

    init(
        movieId: String,
        router: MovieDetailsRouter,
        addReviewUseCase: AddReviewUseCase,
        updateReviewUseCase: UpdateReviewUseCase,
        deleteReviewUseCase: DeleteReviewUseCase,
        fetchMovieUseCase: FetchMovieUseCase,
        getMovieDetailsUseCase: GetMovieDetailsUseCase,
        addFavoriteMovieUseCase: AddFavoriteMovieUseCase,
        deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase
    ) {
        state = .idle
        self.movieId = movieId
        self.router = router
        self.addReviewUseCase = addReviewUseCase
        self.updateReviewUseCase = updateReviewUseCase
        self.deleteReviewUseCase = deleteReviewUseCase
        self.fetchMovieUseCase = fetchMovieUseCase
        self.getMovieDetailsUseCase = getMovieDetailsUseCase
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

        case .reviewDialog(let reviewDialogEvent):
            handleReviewDialogEvent(reviewDialogEvent)

        case .addReviewTapped:
            state = state.addReview()

        case .deleteReviewTapped:
            Task {
                await deleteReview()
                await retrieveMovie()
            }
        }
    }
}

private extension MovieDetailsViewModel {

    func handleReviewDialogEvent(_ event: ReviewDialogViewEvent) {
        switch event {
        case .cancelTapped:
            state = state.cancelReviewEditing()

        case .isAnonymous(let value):
            state = state.isAnonymous(value)

        case .ratingChanged(let rating):
            state = state.updateRating(rating)

        case .reviewTextChanged(let text):
            state = state.updateReviewText(text)

        case .saveTapped:
            state = state.reviewLoading()
            Task {
                await saveReview()
                await retrieveMovie()
            }
        }
    }

    func handleError(_ error: Error) {
        if error as? AuthError == .unauthorized {
            router.showAuthScene()
        } else {
            state = .error(error.localizedDescription)
        }
    }

    func retrieveMovie() async {
        do {
            let movie = try await fetchMovieUseCase.execute(movieId: movieId)
            let movieDetails = try await getMovieDetailsUseCase.execute([movie])[0]
            state = .loaded(getViewData(for: movieDetails))
        } catch {
            handleError(error)
        }
    }

    func favoriteToggled() async {
        guard case .loaded(let viewData) = state else { return }

        do {
            try await viewData.movie.isFavorite
            ? addFavoriteMovieUseCase.execute(movieId)
            : deleteFavoriteMovieUseCase.execute(movieId)
        } catch {
            handleError(error)
        }
    }

    func deleteReview() async {
        guard
            case .loaded(let viewData) = state,
            let selectedReview = viewData.selectedReview
        else { return }

        do {
            try await deleteReviewUseCase.execute(selectedReview.id, movieId: movieId)
            state = state.reviewDeleted()
        } catch {
            handleError(error)
        }
    }

    func saveReview() async {
        guard
            case .loaded(let viewData) = state,
            let reviewDialog = viewData.reviewDialog
        else { return }

        let reviewModify = ReviewModify(
            reviewText: reviewDialog.text,
            rating: reviewDialog.rating,
            isAnonymous: reviewDialog.isAnonymous
        )

        do {
            if let selectedReview = viewData.selectedReview {
                try await updateReviewUseCase.execute(
                    reviewModify,
                    reviewId: selectedReview.id,
                    movieId: movieId
                )
            } else {
                try await addReviewUseCase.execute(review: reviewModify, movieId: movieId)
            }
        } catch {
            handleError(error)
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
        AboutMovieViewModel(
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
        ReviewViewModel(
            id: review.id,
            rating: review.rating,
            isAnonymous: review.isAnonymous,
            isUserReview: review.isUserReview,
            reviewText: review.reviewText,
            createDateTime: review.createDateTime,
            authorNickname: review.author?.nickName,
            authorAvatarLink: review.author?.avatar,
            shouldShowAnonymous: review.isAnonymous && review.isUserReview == false
        )
    }

    func getViewData(for movie: MovieDetails) -> MovieDetailsViewState.ViewData {
        let aboutMovieViewModel = makeAboutMovieViewModel(movie)
        let genreViewModels = makeGenreViewModels(movie.genres ?? [])
        let reviewViewModels = movie.reviews?.compactMap { review in
            makeReviewViewModel(review)
        }.sorted { $0.isUserReview && $1.isUserReview == false }

        let model = MovieDetailsView.Model(
            name: movie.name ?? LocalizedKey.Movie.notAvailable,
            rating: movie.rating,
            poster: movie.poster,
            isFavorite: movie.isFavorite,
            description: movie.description ?? LocalizedKey.Movie.notAvailable,
            shouldShowAddReview: movie.userRating == nil,
            genres: genreViewModels,
            reviewViewModels: reviewViewModels ?? [],
            aboutMovieViewModel: aboutMovieViewModel
        )

        return .init(movie: model)
    }
}
