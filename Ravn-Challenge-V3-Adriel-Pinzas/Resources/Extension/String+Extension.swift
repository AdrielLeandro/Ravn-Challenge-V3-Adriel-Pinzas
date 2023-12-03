//
//  String+Extension.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 30/11/23.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localizedFormat(_ arguments: CVarArg...) -> String {
        return String(format: localized, arguments: arguments)
    }
}
