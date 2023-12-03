//
//  TableView+Extension.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 1/12/23.
//

import UIKit

extension UITableView {

    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: .zero, left: .zero, bottom: value, right: .zero)
        contentInset = edgeInset
        scrollIndicatorInsets = edgeInset
    }
}
