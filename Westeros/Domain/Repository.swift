//
//  Repository.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 14/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import Foundation
import UIKit

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    var houses: [House] { get }
    
}

final class LocalFactory: HouseFactory {

    
    var houses: [House] {
        let starkSigil = Sigil(image: #imageLiteral(resourceName: "codeIsComing.png"), description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: #imageLiteral(resourceName: "lannister.jpg"), description: "Leon Rampante")
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno")
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido")
        
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "", alias: "El Enano", house: lannisterHouse)
        
        starkHouse.add(person: arya)
        starkHouse.add(person: robb)
        lannisterHouse.add(person: tyrion)
        
        return [ starkHouse, lannisterHouse ]
    }
    

}
