//
//  HomeService.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 30/11/23.
//

import Foundation
import Apollo
import SpaceXAPI

struct DefaultError: Error, Codable {
    let key: String
    let message: String
}

protocol HomeServiceProtocol {
    typealias launchesResult = Result<[Launch], Error>
    func fetchLaunches(completion: @escaping (launchesResult) -> Void)
}

final class HomeService: HomeServiceProtocol {
    private let apolloNetwork: ApolloNetwork
    
    init(apolloNetwork: ApolloNetwork = ApolloNetwork.shared) {
        self.apolloNetwork = apolloNetwork
    }
    
    func fetchLaunches(completion: @escaping (launchesResult) -> Void) {
        apolloNetwork.apollo.fetch(query: GetLaunchesQuery(), cachePolicy: .returnCacheDataAndFetch) { result in
            switch result {
            case .success(let graphQLResult):
                if let launchConnection = graphQLResult.data?.launches {
                    let launches = launchConnection.compactMap( { Launch(id: $0?.id ?? "",
                                                                         missionName: $0?.mission_name ?? "",
                                                                         launchDate: $0?.launch_date_local?.toDate(),
                                                                         detail: $0?.details ?? "") } )
                    completion(.success(launches))
                } else {
                    completion(.failure(DefaultError(key: "data.error",
                                                     message: "data.error.message".localized)))
                }
            case .failure(let error):
                completion(.failure(DefaultError(key: "", message: error.localizedDescription.localized)))
            }
        }
    }
}
