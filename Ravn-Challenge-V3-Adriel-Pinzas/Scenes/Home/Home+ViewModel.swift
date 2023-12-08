//
//  Home+ViewModel.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 29/11/23.
//

import Foundation

extension Home {
    struct ViewModel {
        struct LaunchItem {
            let title: String
            let date: String
        }
        
        var title: String
        var items: [LaunchItem]
    }
}
