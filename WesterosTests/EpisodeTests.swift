//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by David Lopez Rodriguez on 23/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import XCTest

@testable import Westeros

class EpisodeTests: XCTestCase {
    
    var formatter: DateFormatter!
    var season1: Season!
    var episode1: Episode!
    var episode2: Episode!
    
    override func setUp() {
        super.setUp()
        
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        season1 = Season(id: 1, name: "Season 1", date: formatter.date(from: "2011-01-01 00:00:00")!)
        episode1 = Episode(id: 1, title: "Episode 1", date: formatter.date(from: "2011-01-01 00:00:00")!, season: season1)
        episode2 = Episode(id: 2, title: "Episode 2", date: formatter.date(from: "2011-01-07 00:00:00")!, season: season1)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEpisodeExistence() {
        XCTAssertNotNil(season1)
    }
    
    func testEpisodeEquality() {
        // Identidad
        XCTAssertEqual(episode1, episode1)
        
        // Igualdad
        let episode = Episode(id: 1, title: "Episode 1", date: formatter.date(from: "2011-01-01 00:00:00")!, season: season1)
        XCTAssertEqual(episode1, episode)
        
        // Desigualdasd
        XCTAssertNotEqual(episode1, episode2)
    }
    
    func testEpisodeDescription() {
        XCTAssertNotNil(episode1.description)
    }
    
    func testEpisodeHashable() {
        XCTAssertNotNil(episode1.hashValue)
    }
    
    func testEpisodeComparison() {
        XCTAssertLessThan(episode1, episode2)
    }
}
