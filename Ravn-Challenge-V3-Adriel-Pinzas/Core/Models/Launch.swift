//
//  Launch.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 3/12/23.
//

import Foundation

struct Launch: Codable, Equatable {
    let id: String
    let missionName: String
    let launchDate: Date?
    let detail: String
}
