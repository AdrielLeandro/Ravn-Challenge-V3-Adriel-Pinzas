//
//  UserDefaultsManager.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 3/12/23.
//

import Foundation


protocol UserDefaultsManagerProtocol {
    func save<T: Encodable>(data: T, key: UserDefaultsManager.UserDefaultsKeys)
    func get<T: Codable>(key: UserDefaultsManager.UserDefaultsKeys) -> T?
}

final class UserDefaultsManager: UserDefaultsManagerProtocol {
    enum UserDefaultsKeys: String {
        case launches
    }
    
    private let defaults = UserDefaults.standard
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    func save<T: Encodable>(data: T, key: UserDefaultsKeys) {
        let data = try? encoder.encode(data)
        defaults.set(data, forKey: key.rawValue)
    }
    
    func get<T: Codable>(key: UserDefaultsKeys) -> T? {
        if let data = UserDefaults.standard.data(forKey: key.rawValue),
           let content =  try? decoder.decode(T.self, from: data) {
            return content
        }
        return nil
    }
}
