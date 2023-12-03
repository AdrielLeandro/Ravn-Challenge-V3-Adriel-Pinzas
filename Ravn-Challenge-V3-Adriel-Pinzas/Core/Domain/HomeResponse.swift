//
//  HomeResponse.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 30/11/23.
//

import Foundation

struct HomeResponse: Codable {
    let launches: [Launch]
}

extension HomeResponse {
    enum Key: String, CodingKey {
        case launches
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        self.launches = try container.decode( [Launch].self, forKey: .launches)
    }
}
