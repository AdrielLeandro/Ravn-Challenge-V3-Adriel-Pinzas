//
//  MockHomeService.swift
//  Ravn-Challenge-V3-Adriel-PinzasTests
//
//  Created by Adriel Pinzas on 7/12/23.
//

import Foundation
@testable import Ravn_Challenge_V3_Adriel_Pinzas

final class MockHomeService: HomeServiceProtocol {
    var shouldSucceed = true
    var didCallfetchLaunches = false
    
    func fetchLaunches(completion: @escaping (launchesResult) -> Void) {
        didCallfetchLaunches = true
        if shouldSucceed {
            let mockLaunches = [Launch(id: "1", missionName: "Mock Launch", launchDate: Date(), detail: "Mock Details")]
            completion(.success(mockLaunches))
        } else {
            let error = NSError(domain: "MockHomeServiceErrorDomain", code: 42, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
            completion(.failure(error))
        }
    }
}
