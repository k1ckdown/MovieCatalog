//
//  AppCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 09.11.2023.
//

import Foundation

@MainActor
final class AppCoordinator: ObservableObject {

    enum State {
        case idle
        case loading
        case auth
        case main
    }

    enum Action {
        case showAuth
        case showMain
        case checkAuthorization
    }

    @Published private(set) var state: State

    private let fetchProfileUseCase: FetchProfileUseCase
    private let fetchFavoriteMoviesUseCase: FetchFavoriteMoviesUseCase

    init(
        fetchProfileUseCase: FetchProfileUseCase,
        fetchFavoriteMoviesUseCase: FetchFavoriteMoviesUseCase
    ) {
        state = .idle
        self.fetchProfileUseCase = fetchProfileUseCase
        self.fetchFavoriteMoviesUseCase = fetchFavoriteMoviesUseCase
    }

    func handle(_ action: Action) {
        switch action {
        case .checkAuthorization:
            Task { await loadData() }
        case .showAuth:
            state = .auth
        case .showMain:
            state = .main
        }
    }
}

private extension AppCoordinator {

    func loadData() async {
        state = .loading

        do {
            _ = try await fetchProfileUseCase.execute()
            state = .main
        } catch {
            state = .auth
        }
    }
}
