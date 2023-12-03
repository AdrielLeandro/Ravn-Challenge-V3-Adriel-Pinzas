//
//  HomeService.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 30/11/23.
//

import Foundation
import Apollo
import SpaceXAPI

struct RequestError: Error, Codable {
    let key: String
    let message: String
}

protocol HomeServiceProtocol {
    typealias launchesResult = Result<[GetLaunchesQuery.Data.Launch], Error>
    func fetchLauches(completion: @escaping (launchesResult) -> Void)
}

final class HomeService: HomeServiceProtocol {
    private let apolloNetwork: ApolloNetwork
    var launches = [GetLaunchesQuery.Data.Launch]()
    
    init(apolloNetwork: ApolloNetwork = ApolloNetwork.shared) {
        self.apolloNetwork = apolloNetwork
    }
    
    func fetchLauches(completion: @escaping (launchesResult) -> Void) {
        apolloNetwork.apollo.fetch(query: GetLaunchesQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                if let launchConnection = graphQLResult.data?.launches {
                    let launches = launchConnection.compactMap( { $0 } )
                    completion(.success(launches))
                } else {
                    completion(.failure(RequestError(key: "json.parsing.error", message: "Parsing error")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
