//
//  NetworkRechabilityManager.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 3/12/23.
//

import Foundation
import Network

protocol NetworkRechabilityManagerDelegate: AnyObject {
    func networkStatusDidChange(connected: Bool)
}

protocol NetworkRechabilityManagerProtocol {
    var isConnected: Bool { get set }
}

class NetworkRechabilityManager: NetworkRechabilityManagerProtocol {
    private var pathMonitor: NWPathMonitor
    private var queue: DispatchQueue
    weak var delegate: NetworkRechabilityManagerDelegate?
    
    var isConnected: Bool = false {
        didSet {
            delegate?.networkStatusDidChange(connected: isConnected)
        }
    }
    
    init() {
        pathMonitor = NWPathMonitor()
        queue = DispatchQueue(label: "NetworkMonitorQueue")

        pathMonitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }

        pathMonitor.start(queue: queue)
    }
    
    deinit {
        pathMonitor.cancel()
    }
    
}
