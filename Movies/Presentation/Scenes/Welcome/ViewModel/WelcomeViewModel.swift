//
//  WelcomeViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import Foundation

final class WelcomeViewModel: ViewModel {

    @Published private(set) var state: WelcomeViewState
    private let navigationState: WelcomeNavigationState

    init(navigationState: WelcomeNavigationState) {
        state = .idle
        self.navigationState = navigationState
    }

    func handle(_ event: WelcomeViewEvent) {
        switch event {
        case .onTapLogIn:
            navigationState.execute(.showLogin)
        case .onTapRegistration:
            navigationState.execute(.showRegistration)
        }
    }
}
