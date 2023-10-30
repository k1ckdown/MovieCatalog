//
//  WelcomeViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import Foundation

enum WelcomeViewState: Equatable {
    case idle
}

enum WelcomeViewEvent {
    case logInTapped
    case registrationTapped
}
