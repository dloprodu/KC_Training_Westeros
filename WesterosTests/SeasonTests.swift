//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by David Lopez Rodriguez on 21/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import XCTest

@testable import Westeros

class SeasonTests: XCTestCase {
    
    var formatter: DateFormatter!
    var season1: Season!
    var season2: Season!
    
    override func setUp() {
        super.setUp()
        
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        season1 = Season(id: 1, name: "Season 1", date: formatter.date(from: "2011-01-01 00:00:00")!)
        season2 = Season(id: 2, name: "Season 2", date: formatter.date(from: "2012-01-01 00:00:00")!)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSeasonExistence() {
        XCTAssertNotNil(season1)
    }
    
    func testSeasonEquality() {
        // Identidad
        XCTAssertEqual(season1, season1)
        
        // Igualdad
        let season = Season(id: 1, name: "Season 1", date: formatter.date(from: "2011-01-01 00:00:00")!)
        XCTAssertEqual(season1, season)
        
        // Desigualdasd
        XCTAssertNotEqual(season1, season2)
    }
    
    func testSeasonDescription() {
        XCTAssertNotNil(season1.description)
    }
    
    func testSeasonHashable() {
        XCTAssertNotNil(season1.hashValue)
    }
    
    func testSeasonComparison() {
        XCTAssertLessThan(season1, season2)
    }
}
