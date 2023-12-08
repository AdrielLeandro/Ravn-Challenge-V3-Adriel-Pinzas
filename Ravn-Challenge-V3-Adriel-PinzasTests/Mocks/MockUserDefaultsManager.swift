//
//  MockUserDefaultsManager.swift
//  Ravn-Challenge-V3-Adriel-PinzasTests
//
//  Created by Adriel Pinzas on 7/12/23.
//

import Foundation
@testable import Ravn_Challenge_V3_Adriel_Pinzas

final class MockUserDefaultsManager: UserDefaultsManagerProtocol {
    var savedData: [UserDefaultsManager.UserDefaultsKeys: Any] = [:]

    func save<T: Encodable>(data: T, key: UserDefaultsManager.UserDefaultsKeys) {
        savedData[key] = data
    }

    func get<T: Codable>(key: UserDefaultsManager.UserDefaultsKeys) -> T? {
        return savedData[key] as? T
    }
}
