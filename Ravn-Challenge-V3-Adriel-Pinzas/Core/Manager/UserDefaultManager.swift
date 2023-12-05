//
//  UserDefaultManager.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 3/12/23.
//

import Foundation


protocol UserDefaultManagerProtocol {
    func save<T: Encodable>(data: T, key: UserDefaultManager.UserDefaultKeys)
    func get<T: Codable>(key: UserDefaultManager.UserDefaultKeys) -> T?
}

class UserDefaultManager: UserDefaultManagerProtocol {
    enum UserDefaultKeys: String {
        case launches
    }
    
    private let defaults = UserDefaults.standard
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    func save<T: Encodable>(data: T, key: UserDefaultKeys) {
        let data = try? encoder.encode(data)
        defaults.set(data, forKey: key.rawValue)
    }
    
    func get<T: Codable>(key: UserDefaultKeys) -> T? {
        if let data = UserDefaults.standard.data(forKey: key.rawValue),
           let content =  try? decoder.decode(T.self, from: data) {
            return content
        }
        return nil
    }
}
