//
//  CharacterTests.swift
//  WesterosTests
//
//  Created by David Lopez Rodriguez on 08/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import XCTest

@testable import Westeros

class PersonTests: XCTestCase {
    
    // con ! declara como opcional y al usar la variable la desempaqueta
    // automáticamente (cuidado con esto!)
    var starkHouse: House!
    var starkSigil: Sigil!
    var ned: Person!
    var aria: Person!
    
    override func setUp() {
        super.setUp()
        
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno")
        ned = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        aria = Person(name: "Aria", house: starkHouse)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPersonExistence() {
        XCTAssertNotNil(ned)
        XCTAssertNotNil(aria)
    }
    
    func testPersonFullName() {
        XCTAssertEqual(ned.fullName, "Eddard Stark")
    }
}
