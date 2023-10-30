//
//  WelcomeViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import Foundation

final class WelcomeViewModel: ViewModel {

    @Published private(set) var state: WelcomeViewState
    private let coordinator: AuthCoordinatorProtocol

    init(coordinator: AuthCoordinatorProtocol) {
        state = .idle
        self.coordinator = coordinator
    }

    func handle(_ event: WelcomeViewEvent) {
        switch event {
        case .onTapLogIn:
            coordinator.showLogin()

        case .onTapRegistration:
            coordinator.showPersonalInfoRegistration()
        }
    }
}
