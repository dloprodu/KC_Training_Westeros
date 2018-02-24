//
//  RepositoryFactory.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 23/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import Foundation

enum HouseKey : String {
    case targaryen
    case stark
    case lannister
    case tyrrel
    case baratheon
    case bolton
    case martell
}

protocol RepositoryFactory {
    typealias FilterHouse = (House) -> Bool
    typealias FilterSeason = (Season) -> Bool
    
    var houses: [House] { get }
    func house(name: String) -> House?
    func houses(filteredBy: FilterHouse) -> [House]
    
    var seasons: [Season] { get }
    func season(name: String) -> Season?
    func seasons(filteredBy: FilterSeason) -> [Season]
}
