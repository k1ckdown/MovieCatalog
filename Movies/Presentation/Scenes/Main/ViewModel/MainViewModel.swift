//
//  MainViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class MainViewModel: ViewModel {

    @Published private(set) var state: MainViewState

    init() {
        self.state = .idle
    }

    func handle(_ event: MainViewEvent) {
        switch event {
        case .onAppear:
            state = .loading

        case .onSelectMovie(let id):
            print(id)
        }
    }
}
