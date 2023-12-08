//
//  DateExtensionTests.swift
//  Ravn-Challenge-V3-Adriel-PinzasTests
//
//  Created by Adriel Pinzas on 7/12/23.
//

import XCTest
@testable import Ravn_Challenge_V3_Adriel_Pinzas

final class DateExtensionTests: XCTestCase {
    func testToString() {
        let date = Date(timeIntervalSince1970: 1638870000)
        let expectedDateString = "07 December 2021"

        let result = date.toString()

        XCTAssertEqual(result, expectedDateString, "Formatted date string should match the expected result")
    }
}
