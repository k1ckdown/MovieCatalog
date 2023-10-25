//
//  AuthFlowState.swift
//  Movies
//
//  Created by Ivan Semenov on 24.10.2023.
//

import SwiftUI

final class AuthFlowState: FlowState {
    
    enum Screen: Routable {
        case login
        case registrationFirstStage
        case registrationSecondStage
    }
    
    @Published var navigationPath = [Screen]()
}
