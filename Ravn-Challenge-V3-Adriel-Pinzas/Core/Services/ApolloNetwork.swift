//
//  ApolloNetwork.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 2/12/23.
//

import Apollo
import SpaceXAPI
import Foundation

final class ApolloNetwork {
    static let shared = ApolloNetwork()

    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://main--spacex-l4uc6p.apollographos.net/graphql")!)
}
