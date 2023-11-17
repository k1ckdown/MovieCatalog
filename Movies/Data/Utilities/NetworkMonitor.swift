//
//  NetworkMonitor.swift
//  Movies
//
//  Created by Ivan Semenov on 17.11.2023.
//

import Foundation
import Network

final class NetworkMonitor: @unchecked Sendable {

    static let shared = NetworkMonitor()

    private(set) var isConnected = false

    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkMonitor")

    private init() {
        monitor = NWPathMonitor()
    }

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }

        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
