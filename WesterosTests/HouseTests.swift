//
//  HouseTests.swift
//  WesterosTests
//
//  Created by David Lopez Rodriguez on 08/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import XCTest
@testable import Westeros

class HouseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHouseExistence() {
        let sigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        let stark = House(name: "Stark", sigil: sigil, words: "Se acerca el invierno")
        // when
        // then
        XCTAssertNotNil(stark)
    }
    
    func testSigilExistence() {
        let starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        
        XCTAssertNotNil(starkSigil)
        
        let lanisterSigil = Sigil(image: UIImage(), description: "Leon Rampante");
        
        XCTAssertNotNil(lanisterSigil)
    }
}
