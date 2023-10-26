//
//  FlowFactory.swift
//  Movies
//
//  Created by Ivan Semenov on 25.10.2023.
//

import Foundation

@MainActor
final class FlowFactory {

    private let appFactory: AppFactory

    init(appFactory: AppFactory) {
        self.appFactory = appFactory
    }
}

extension FlowFactory {

    func makeAuthFlow() -> AuthFlow {
        let factory = AuthScreenFactory(appFactory: appFactory)
        let flow = AuthFlow(factory: factory)
        
        return flow
    }

}
