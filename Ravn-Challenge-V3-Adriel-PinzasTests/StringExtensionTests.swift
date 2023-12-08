//
//  StringExtensionTests.swift
//  Ravn-Challenge-V3-Adriel-PinzasTests
//
//  Created by Adriel Pinzas on 7/12/23.
//

import XCTest
@testable import Ravn_Challenge_V3_Adriel_Pinzas

final class StringExtensionTests: XCTestCase {
    func testLocalized() {
        let localizedStringKey = "TestLocalizedStringKey"
        let localizedString = localizedStringKey.localized
        
        XCTAssertEqual(localizedString, NSLocalizedString(localizedStringKey, comment: ""))
    }

    func testToDate() {
        let dateString = "2023-12-07T12:34:56+0000"
        let expectedDate = ISO8601DateFormatter().date(from: dateString)

        let convertedDate = dateString.toDate()

        XCTAssertEqual(convertedDate, expectedDate)
    }
}
