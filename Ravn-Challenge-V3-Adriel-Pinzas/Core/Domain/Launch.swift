//
//  Launch.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 30/11/23.
//

import Foundation

struct Launch: Codable {
    var id: String?
    let details: String?
    let name: String?
    let date: String?
}

extension Launch {
    enum Key: String, CodingKey {
        case id
        case details
        case mission_name
        case launch_date_local
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.id = try? container.decode(String.self, forKey: .id)
        self.details = try? container.decode(String.self, forKey: .details)
        self.name = try? container.decode(String.self, forKey: .mission_name)
        self.date = try? container.decode(String.self, forKey: .launch_date_local)
    }
}
