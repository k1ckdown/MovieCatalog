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
        case loading
        case auth
        case main
    }

    enum Action {
        case checkProfile
        case showAuth
        case showMain
    }

    @Published private(set) var state: State
    private let fetchProfileUseCase: FetchProfileUseCase

    init(fetchProfileUseCase: FetchProfileUseCase) {
        state = .auth
        self.fetchProfileUseCase = fetchProfileUseCase
    }

    func handle(_ action: Action) {
        switch action {
        case .checkProfile:
            Task { await getProfile() }
        case .showAuth:
            state = .auth
        case .showMain:
            state = .main
        }
    }
}

private extension AppCoordinator {

    func getProfile() async {
        state = .loading
        do {
            let _ = try await fetchProfileUseCase.execute()
            state = .main
        } catch {
            state = .auth
        }
    }
}
