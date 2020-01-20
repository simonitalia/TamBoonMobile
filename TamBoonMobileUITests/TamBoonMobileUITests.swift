//
//  TamBoonMobileUITests.swift
//  TamBoonMobileUITests
//
//  Created by Simon Italia on 1/15/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import XCTest
@testable import TamBoonMobile

class TamBoonMobileUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    //MARK: Charities Table View Controller Scene tests
    func testCharitiesTableVCTitleIsCorrectAftreDataLoad() {
        let app = XCUIApplication()
        
        XCTAssert(app.staticTexts["Select Charity"].exists)
    }
    
    
    //MARK: Charity Detail View Controller Scene tests
    func testCharityDetailVCTitleIsCorrect() {
        let app = XCUIApplication()
        
        XCTAssert(app.staticTexts["Habitat for Humanity"].exists)
    }
    
    func testCharityVCContinueButtonExists() {
        let app = XCUIApplication()
    
        XCTAssertTrue(app.buttons["CONTINUE"].exists)
    }
    
    func testContinueButtonDisplaysSubmitDonationVC() {
        let app = XCUIApplication()
        
        app.buttons["CONTINUE"].tap()
        
        XCTAssert(app.buttons["DONATE"].waitForExistence(timeout: 2))
    }
    
    //MARK: Charity Submit Donation View Controller Scene tests
    func testSubmitDonationShowsSuccessAlert() {
        let app = XCUIApplication()
        
        app.buttons["DONATE"].tap()
        
        XCTAssertTrue(app.alerts["Thank you! ❤️"].waitForExistence(timeout: 10))
    }
}
