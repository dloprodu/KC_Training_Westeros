//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by David Lopez Rodriguez on 14/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import XCTest
@testable import Westeros

class RepositoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLocalRepositoryCreation() {
        let repo = Repository.local
        XCTAssertNotNil(repo)
    }
    
    func testLocalRepositoryHousesCreation() {
        let houses = Repository.local.houses
        XCTAssertNotNil(houses)
        XCTAssertGreaterThan(houses.count, 0)
    }
}
