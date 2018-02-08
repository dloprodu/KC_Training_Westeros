//
//  CharacterTests.swift
//  WesterosTests
//
//  Created by David Lopez Rodriguez on 08/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import XCTest

@testable import Westeros

class CharacterTests: XCTestCase {
    
    // con ! declara como opcional y al usar la variable la desempaqueta
    // automáticamente (cuidado con esto!)
    var starkHouse: House!
    var starkSigil: Sigil!
    
    override func setUp() {
        super.setUp()
        
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCharacterExistence() {
        let character = Character(name: "Eddard", alias: "Ned", house: starkHouse)
        XCTAssertNotNil(character)
        
        let aria = Character(name: "Aria", house: starkHouse)
        XCTAssertNotNil(aria)
    }
    
}
