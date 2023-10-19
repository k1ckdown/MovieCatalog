//
//  RegistrationViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import Foundation

protocol RegistrationViewModelProtocol:
    ViewModel where State == RegistrationViewState, Event == RegistrationViewEvent {}

final class RegistrationViewModel: RegistrationViewModelProtocol {

    @Published private(set) var state: RegistrationViewState

    init() {
        state = .init()
    }

    func handle(_ event: RegistrationViewEvent) {
        
    }
}


