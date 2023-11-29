//
//  Ravn_Challenge_V3_Adriel_PinzasUITestsLaunchTests.swift
//  Ravn-Challenge-V3-Adriel-PinzasUITests
//
//  Created by Adriel Pinzas on 29/11/23.
//

import XCTest

final class Ravn_Challenge_V3_Adriel_PinzasUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
