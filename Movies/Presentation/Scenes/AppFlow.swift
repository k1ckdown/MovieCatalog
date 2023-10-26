//
//  AppFlow.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

struct AppFlow: View {

    private let flowFactory: FlowFactory

    init(flowFactory: FlowFactory) {
        self.flowFactory = flowFactory
    }

    var body: some View {
        flowFactory.makeAuthFlow()
    }
}

#Preview {
    AppFlow(flowFactory: .init())
        .environment(\.locale, .init(identifier: "ru"))
}
