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
    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!
    
    override func setUp() {
        super.setUp()
        
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        lannisterSigil = Sigil(image: UIImage(), description: "Leon Rampante")
        
        starkHouse = House(id: 1, name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Stark")!)
        lannisterHouse = House(id: 2, name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Lannister")!)
        
        robb = Person(id: 1, name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        arya = Person(id: 2, name: "Arya", house: starkHouse)
        tyrion = Person(id: 3, name: "Tyrion", alias: "El Enano", house: lannisterHouse)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPersonExistence() {
        XCTAssertNotNil(robb)
        XCTAssertNotNil(arya)
    }
    
    func testPersonFullName() {
        XCTAssertEqual(robb.fullName, "Robb Stark")
    }
    
    func testPersonEquality() {
        // Identidad
        XCTAssertEqual(tyrion, tyrion)
        
        // Igualdad
        let enano = Person(id: 3, name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        XCTAssertEqual(tyrion, enano)
        
        // Desigualdad
        XCTAssertNotEqual(arya, tyrion)
    }
}
