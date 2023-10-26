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
        case personalInfoRegistration
        case passwordRegistration
    }
    
    @Published var navigationPath = [Screen]()
}
