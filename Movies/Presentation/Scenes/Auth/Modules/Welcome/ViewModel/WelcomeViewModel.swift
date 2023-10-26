//
//  WelcomeViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import Foundation

final class WelcomeViewModel: ViewModel {

    @Published private(set) var state: WelcomeViewState
    private let router: WelcomeRouter

    init(router: WelcomeRouter) {
        state = .idle
        self.router = router
    }

    func handle(_ event: WelcomeViewEvent) {
        switch event {
        case .onTapLogIn:
            router.showLogin()

        case .onTapRegistration:
            router.showRegistration()
        }
    }
}
