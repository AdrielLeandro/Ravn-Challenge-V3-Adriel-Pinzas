//
//  Home+Content.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 30/11/23.
//

import Foundation
import SpaceXAPI

extension Home {
    struct Content {
        let launches: [GetLaunchesQuery.Data.Launch]
    }
}
