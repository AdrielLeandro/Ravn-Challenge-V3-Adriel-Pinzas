//
//  DataResponse.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 1/12/23.
//

import Foundation

struct DataResponse: Codable {
    let data: HomeResponse
}

extension DataResponse {
    enum Key: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.data = try container.decode(HomeResponse.self, forKey: .data)
    }
}
