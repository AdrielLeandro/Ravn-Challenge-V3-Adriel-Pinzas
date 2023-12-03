//
//  SearchService.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 2/12/23.
//

import Foundation

protocol SearchServiceProtocol {
    func filterLaunches(_ launches: [Launch], using searchText: String) -> [Launch]
}

final class SearchService: SearchServiceProtocol {
    
    func filterLaunches(_ launches: [Launch], using searchText: String) -> [Launch] {
        let filtered = launches.filter { launch in
            return searchText.isEmpty || launch.name?.lowercased().range(of: searchText.lowercased()) != nil
        }
        return filtered
    }
}
