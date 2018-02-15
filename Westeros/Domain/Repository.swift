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
    typealias Filter = (House) -> Bool
    
    var houses: [House] { get }
    func house(name: String) -> House?
    func houses(filteredBy: Filter) -> [House]
}

final class LocalFactory: HouseFactory {

    
    var houses: [House] {
        let starkSigil = Sigil(image: #imageLiteral(resourceName: "codeIsComing.png"), description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: #imageLiteral(resourceName: "lannister.jpg"), description: "Leon Rampante")
        let targaryenSigil = Sigil(image: #imageLiteral(resourceName: "targaryenSmall.jpg"), description: "Dragón Tricéfalo")
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        let targaryenHouse = House(name: "Targarien", sigil: targaryenSigil, words: "Fuego y Sangre", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
        
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        
        let tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El matareyes", house: lannisterHouse)
        
        let dani = Person(name: "Daenerys", alias: "Madre de Dragones", house: targaryenHouse)
        
        starkHouse.add(person: arya)
        starkHouse.add(person: robb)
        
        lannisterHouse.add(person: tyrion)
        lannisterHouse.add(person: cersei)
        lannisterHouse.add(person: jaime)
        
        targaryenHouse.add(person: dani)
        
        return [ starkHouse, lannisterHouse, targaryenHouse ].sorted()
    }
    
    func house(name: String) -> House? {
        return houses.filter{ $0.name.uppercased() == name.uppercased() }.first
    }

    func houses(filteredBy: Filter) -> [House] {
        return houses.filter(filteredBy)
    }
}
