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

enum HouseKey : String {
    case targaryen
    case stark
    case lannister
    case tyrrel
    case baratheon
    case bolton
    case martell
}

final class LocalFactory: HouseFactory {
    private let _sigils: [HouseKey: Sigil]
    private let _houses: [HouseKey: House]
    
    init() {
       self._sigils = [
            HouseKey.targaryen: Sigil(image: #imageLiteral(resourceName: "targaryen.png"), description: "Sable, a dragon thrice-headed gules"),
            HouseKey.stark:     Sigil(image: #imageLiteral(resourceName: "stark.png"), description: "A running grey direwolf, on an ice-white field"),
            HouseKey.baratheon: Sigil(image: #imageLiteral(resourceName: "baratheon.png"), description: "A black crowned stag, on a gold field"),
            HouseKey.bolton:    Sigil(image: #imageLiteral(resourceName: "bolton.png"), description: "A red flayed man, hanging upside-down on a white X-shaped cross, on a black background"),
            HouseKey.lannister: Sigil(image: #imageLiteral(resourceName: "lannister.png"), description: "A gold lion, on a crimson field (Gules, a lion or)"),
            HouseKey.tyrrel:    Sigil(image: #imageLiteral(resourceName: "tyrell.png"), description: "A golden rose, on a green field"),
            HouseKey.martell:   Sigil(image: #imageLiteral(resourceName: "martell.png"), description: "A gold spear piercing a red sun on an orange field")
        ]
        
        self._houses = [
            HouseKey.stark:     House(name: "Stark", sigil: _sigils[HouseKey.stark]!, words: "Winter is Coming", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!),
            HouseKey.lannister: House(name: "Lannister", sigil: _sigils[HouseKey.lannister]!, words: "Hear Me Roar!", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!),
            HouseKey.targaryen: House(name: "Targarien", sigil: _sigils[HouseKey.targaryen]!, words: "Fire and Blood", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!),
            HouseKey.bolton:    House(name: "Bolton", sigil: _sigils[HouseKey.bolton]!, words: "Our Blades Are Sharp", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Bolton")!),
            HouseKey.tyrrel:    House(name: "Tyrrel", sigil: _sigils[HouseKey.tyrrel]!, words: "Growing Strong", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Tyrell")!),
            HouseKey.baratheon: House(name: "Baratheon", sigil: _sigils[HouseKey.baratheon]!, words: "Ours is the Fury", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Baratheon")!),
            HouseKey.martell:   House(name: "Martell", sigil: _sigils[HouseKey.martell]!, words: "Unbowed, Unbent, Unbroken", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Martell")!),
        ]
        
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: _houses[HouseKey.stark]!)
        let arya = Person(name: "Arya", house: _houses[HouseKey.stark]!)
        
        _houses[HouseKey.stark]?.add(persons: robb, arya)
        
        let tyrion = Person(name: "Tyrion", alias: "El Enano", house: _houses[HouseKey.lannister]!)
        let cersei = Person(name: "Cersei", house: _houses[HouseKey.lannister]!)
        let jaime = Person(name: "Jaime", alias: "El matareyes", house: _houses[HouseKey.lannister]!)
        
        _houses[HouseKey.lannister]?.add(persons: tyrion, cersei, jaime)
        
        let dani = Person(name: "Daenerys", alias: "Madre de Dragones", house: _houses[HouseKey.targaryen]!)
        
        _houses[HouseKey.targaryen]?.add(persons: dani)
    }
    
    var houses: [House] {
        return _houses.values.sorted()
    }
    
    func house(name: String) -> House? {
        return houses.filter{ $0.name.uppercased() == name.uppercased() }.first
    }

    func houses(filteredBy: Filter) -> [House] {
        return houses.filter(filteredBy)
    }
}
