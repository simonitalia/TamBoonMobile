//
//  TamBoonMobileTests.swift
//  TamBoonMobileTests
//
//  Created by Simon Italia on 1/15/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import XCTest
@testable import TamBoonMobile

class TamBoonMobileTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK: Data model tests
    func testCharityObjectDefinition() {
        //given
        let sut: Charity
            //note, sut = system under test (common practice for naming objects subjected to test)
        
        //when
        sut = Charity(id: 0, name: "Ban Khru Noi", logoURL: "http://rkdretailiq.com/news/img-corporate-baankrunoi.jpg")
        
        //then
        XCTAssertEqual(sut.id, 0)
        XCTAssertEqual(sut.name, "Ban Khru Noi")
        XCTAssertEqual(sut.logoURL, "http://rkdretailiq.com/news/img-corporate-baankrunoi.jpg")
    }
    
    func testDonationObjectDefinition() {
        //given
        let sut: Donation
        
        //when
        sut = Donation(name: "John Smith", token: "tokn_test_123", amount: 1000)
        
        //then
        XCTAssertEqual(sut.name, "John Smith")
        XCTAssertEqual(sut.token, "tokn_test_123")
        XCTAssertEqual(sut.amount, 1000)
    }
    
    func testRemoteAPIServerBaseURLIsCorrect() {
        //given
        let sut = CharitiesController()
        
        //when
        let urlToTest = URL(string:"https://virtserver.swaggerhub.com/chakritw/tamboon-api/1.0.0/")
        
        //then
        XCTAssertEqual(sut.baseURL, urlToTest)
    }
    
    //MARK: CharitiesTableViewController tests
    func testCharitiesTableViewExists() {
        //given
        let sut = CharitiesTableViewController()
        
        //when
        sut.loadViewIfNeeded()
        
        //then
        XCTAssertNotNil(sut.tableView)
    }
    
    func testCharitiesTableViewHasCorrectRowCount() {
        //given
        let sut = CharitiesTableViewController()
        
        //when
        sut.loadViewIfNeeded()
        
        //then
        let rowCount = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rowCount, sut.charities.count)
    }
    
    func testCharitiesTableViewControllerHasLargeTitles() {
        //given
        let sut = CharitiesTableViewController()
        _ = UINavigationController(rootViewController: sut)
        
        //when
        sut.loadViewIfNeeded()
        
        //then
        XCTAssertTrue(sut.navigationController?.navigationBar.prefersLargeTitles ?? true)
    }
    
    func testCharitiesViewControllerHasCorrectTitle() {
        //given
        let sut = CharitiesTableViewController()
        
        //when
        sut.loadViewIfNeeded()
        
        //then
        XCTAssertEqual(sut.title, "Select Charity")
    }
    
}
