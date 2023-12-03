//
//  SearchService.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 2/12/23.
//

import Foundation
import SpaceXAPI

protocol SearchServiceProtocol {
    func filterLaunches(_ launches: [GetLaunchesQuery.Data.Launch], using searchText: String) -> [GetLaunchesQuery.Data.Launch]
}

final class SearchService: SearchServiceProtocol {
    
    func filterLaunches(_ launches: [GetLaunchesQuery.Data.Launch], using searchText: String) -> [GetLaunchesQuery.Data.Launch] {
        let filtered = launches.filter { launch in
            return searchText.isEmpty || launch.mission_name?.lowercased().range(of: searchText.lowercased()) != nil
        }
        return filtered
    }
}
