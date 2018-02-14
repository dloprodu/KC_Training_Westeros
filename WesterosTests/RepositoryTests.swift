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
    
    var localHouses: [House]!
    
    override func setUp() {
        super.setUp()
        localHouses = Repository.local.houses
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLocalRepositoryCreation() {
        let repo = Repository.local
        XCTAssertNotNil(repo)
    }
    
    func testLocalRepositoryHousesCreation() {
        XCTAssertNotNil(localHouses)
        XCTAssertGreaterThan(localHouses.count, 0)
    }
    
    func testLocalRepositoryReturnsSortedArryOfHouses() {
        XCTAssertEqual(localHouses, localHouses.sorted())
    }
    
    func testLocalRepositoryReturnHouseByCaseInsensitively() {
        let stark = Repository.local.house(name: "sTarK")
        XCTAssertEqual(stark?.name, "Stark")
    }
}
