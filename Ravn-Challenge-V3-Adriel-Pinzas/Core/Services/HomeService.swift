//
//  HomeService.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 30/11/23.
//

import Foundation

protocol HomeServiceProtocol {
    typealias lauchesResult = Result<HomeResponse, Error>
    func fetchLauches(completion: @escaping (lauchesResult) -> Void)
}

final class HomeService: HomeServiceProtocol {
    private let manager: ServiceManager
    
    init(manager: ServiceManager) {
        self.manager = manager
    }
    
    func fetchLauches(completion: @escaping (lauchesResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
            
            if let path = Bundle.main.path(forResource: "HomeJson", ofType: "json") {
                do {
                    guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
                          let response = try? JSONDecoder().decode(DataResponse.self,
                                                                   from: data).data else {
                        completion(.failure(RequestError(key: "json.parsing.error", message: "Parse error")))
                        return
                    }
                    completion(.success(response))
                }
            }
        })
        
        
//        manager.request("url", method: .get, parameters: nil, headers: nil) { (result: Result<HomeResponseDTO, RequestError>) in
//            switch result {
//            case .success(let response):
//                completion(.success(response))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
    }
}
