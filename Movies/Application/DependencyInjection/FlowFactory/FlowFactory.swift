//
//  FlowFactory.swift
//  Movies
//
//  Created by Ivan Semenov on 25.10.2023.
//

import Foundation

@MainActor
final class FlowFactory {

}

extension FlowFactory {
    func makeAuthFlow() -> AuthFlow {
        let factory = AuthScreenFactory()
        let flow = AuthFlow(factory: factory)

        return flow
    }
}
