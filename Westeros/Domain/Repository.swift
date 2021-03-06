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

final class LocalFactory: RepositoryFactory {
    private let _sigils: [HouseKey: Sigil]
    private let _houses: [House]
    private let _seasons: [Season]
    
    init() {
        let loremipum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        // Sigils
        self._sigils = [
            HouseKey.targaryen: Sigil(image: #imageLiteral(resourceName: "targaryen.png"), description: "Sable, a dragon thrice-headed gules"),
            HouseKey.stark: Sigil(image: #imageLiteral(resourceName: "stark.png"), description: "A running grey direwolf, on an ice-white field"),
            HouseKey.baratheon: Sigil(image: #imageLiteral(resourceName: "baratheon.png"), description: "A black crowned stag, on a gold field"),
            HouseKey.bolton: Sigil(image: #imageLiteral(resourceName: "bolton.png"), description: "A red flayed man, hanging upside-down on a white X-shaped cross, on a black background"),
            HouseKey.lannister: Sigil(image: #imageLiteral(resourceName: "lannister.png"), description: "A gold lion, on a crimson field (Gules, a lion or)"),
            HouseKey.tyrrel: Sigil(image: #imageLiteral(resourceName: "tyrell.png"), description: "A golden rose, on a green field"),
            HouseKey.martell: Sigil(image: #imageLiteral(resourceName: "martell.png"), description: "A gold spear piercing a red sun on an orange field")
        ]
        
        // Houses
        self._houses = [
            House(id: 1, name: "Stark", sigil: _sigils[HouseKey.stark]!, words: "Winter is Coming", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!),
            House(id: 2, name: "Lannister", sigil: _sigils[HouseKey.lannister]!, words: "Hear Me Roar!", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!),
            House(id: 3, name: "Targarien", sigil: _sigils[HouseKey.targaryen]!, words: "Fire and Blood", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!),
            House(id: 4, name: "Bolton", sigil: _sigils[HouseKey.bolton]!, words: "Our Blades Are Sharp", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Bolton")!),
            House(id: 5, name: "Tyrrel", sigil: _sigils[HouseKey.tyrrel]!, words: "Growing Strong", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Tyrell")!),
            House(id: 6, name: "Baratheon", sigil: _sigils[HouseKey.baratheon]!, words: "Ours is the Fury", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Baratheon")!),
            House(id: 7, name: "Martell", sigil: _sigils[HouseKey.martell]!, words: "Unbowed, Unbent, Unbroken", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Martell")!),
        ]
        
        // Members
        let robb = Person(id: 1, name: "Robb", alias: "El Joven Lobo", house: _houses[0])
        let arya = Person(id: 2, name: "Arya", house: _houses[0])
        
        _houses[0].add(persons: robb, arya)
        
        let tyrion = Person(id: 3, name: "Tyrion", alias: "El Enano", house: _houses[1])
        let cersei = Person(id: 4, name: "Cersei", house: _houses[1])
        let jaime = Person(id: 5, name: "Jaime", alias: "El matareyes", house: _houses[1])
        
        _houses[1].add(persons: tyrion, cersei, jaime)
        
        let dani = Person(id: 6, name: "Daenerys", alias: "Madre de Dragones", house: _houses[2])
        
        _houses[2].add(persons: dani)
        
        // Seasons
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let season1 = Season(
            id: 1,
            name: "Season 1",
            date: formatter.date(from: "2011-04-17 00:00:00")!,
            image: #imageLiteral(resourceName: "season-1.jpg"))
        let season2 = Season(
            id: 2,
            name: "Season 2",
            date: formatter.date(from: "2012-04-01 00:00:00")!,
            image: #imageLiteral(resourceName: "season-2.jpg"))
        let season3 = Season(
            id: 3,
            name: "Season 3",
            date: formatter.date(from: "2013-03-31 00:00:00")!,
            image: #imageLiteral(resourceName: "season-3.jpg"))
        let season4 = Season(
            id: 4,
            name: "Season 4",
            date: formatter.date(from: "2014-04-06 00:00:00")!,
            image: #imageLiteral(resourceName: "season-4.jpg"))
        let season5 = Season(
            id: 5,
            name: "Season 5",
            date: formatter.date(from: "2015-04-12 00:00:00")!,
            image: #imageLiteral(resourceName: "season-5.jpg"))
        let season6 = Season(
            id: 6,
            name: "Season 6",
            date: formatter.date(from: "2016-04-24 00:00:00")!,
            image: #imageLiteral(resourceName: "season-6.jpg"))
        let season7 = Season(
            id: 7,
            name: "Season 7",
            date: formatter.date(from: "2017-07-16 00:00:00")!,
            image: #imageLiteral(resourceName: "season-7.jpg"))
        
        season1.add(episodes:
            Episode(id: 1, title: "Winter Is Coming", summary: loremipum, date: formatter.date(from: "2011-04-17 00:00:00")!, image: #imageLiteral(resourceName: "s1e1.jpg"), season: season1),
            Episode(id: 2, title: "The Kingsroad", summary: loremipum, date: formatter.date(from: "2011-04-24 00:00:00")!, image: #imageLiteral(resourceName: "s1e2.jpg"), season: season1),
            Episode(id: 3, title: "Lord Snow", summary: loremipum, date: formatter.date(from: "2011-05-01 00:00:00")!, image: #imageLiteral(resourceName: "s1e3.jpg"), season: season1))
        
        season2.add(episodes:
            Episode(id: 21, title: "The North Remembers", summary: loremipum, date: formatter.date(from: "2012-04-01 00:00:00")!, image: #imageLiteral(resourceName: "s2e1.jpg"), season: season2),
            Episode(id: 22, title: "The Night Lands", summary: loremipum, date: formatter.date(from: "2012-04-08 00:00:00")!, image: #imageLiteral(resourceName: "s2e2.jpg"), season: season2),
            Episode(id: 23, title: "What Is Dead May Never Die", summary: loremipum, date: formatter.date(from: "2012-04-15 00:00:00")!, image: #imageLiteral(resourceName: "s2e3.jpg"), season: season2))
        
        season3.add(episodes:
            Episode(id: 31, title: "Valar Dohaeris", summary: loremipum, date: formatter.date(from: "2013-03-31 00:00:00")!, image: #imageLiteral(resourceName: "s3e1.jpg"), season: season3),
            Episode(id: 32, title: "Dark Wings, Dark Words", summary: loremipum, date: formatter.date(from: "013-04-07 00:00:00")!, image: #imageLiteral(resourceName: "s3e2.jpg"), season: season3),
            Episode(id: 33, title: "Walk of Punishment", summary: loremipum, date: formatter.date(from: "2013-04-14 00:00:00")!, image: #imageLiteral(resourceName: "s3e3.jpg"), season: season3))
        
        season4.add(episodes:
            Episode(id: 41, title: "Two Swords", summary: loremipum, date: formatter.date(from: "2014-04-06 00:00:00")!, image: #imageLiteral(resourceName: "s4e1.jpg"), season: season4),
            Episode(id: 42, title: "The Lion and the Rose", summary: loremipum, date: formatter.date(from: "2014-04-13 00:00:00")!, image: #imageLiteral(resourceName: "s4e2.jpg"), season: season4),
            Episode(id: 43, title: "Breaker of Chains", summary: loremipum, date: formatter.date(from: "2014-04-20 00:00:00")!, image: #imageLiteral(resourceName: "s4e3.jpg"), season: season4))
        
        season5.add(episodes:
            Episode(id: 51, title: "The Wars to Come", summary: loremipum, date: formatter.date(from: "2015-04-12 00:00:00")!, image: #imageLiteral(resourceName: "s5e1.jpg"), season: season5),
            Episode(id: 52, title: "The House of Black and White", summary: loremipum, date: formatter.date(from: "2015-04-19 00:00:00")!, image: #imageLiteral(resourceName: "s5e2.jpg"), season: season5),
            Episode(id: 53, title: "High Sparrow", summary: loremipum, date: formatter.date(from: "2015-04-26 00:00:00")!, image: #imageLiteral(resourceName: "s5e3.jpg"), season: season5))
        
        season6.add(episodes:
            Episode(id: 61, title: "The Red Woman", summary: loremipum, date: formatter.date(from: "2016-04-24 00:00:00")!, image: #imageLiteral(resourceName: "s6e1.jpg"), season: season6),
            Episode(id: 62, title: "Home", summary: loremipum, date: formatter.date(from: "2016-05-01 00:00:00")!, image: #imageLiteral(resourceName: "s6e2.jpg"), season: season6),
            Episode(id: 63, title: "Oathbreaker", summary: loremipum, date: formatter.date(from: "2016-05-08 00:00:00")!, image: #imageLiteral(resourceName: "s6e3.jpg"), season: season6))
        
        season7.add(episodes:
            Episode(id: 71, title: "Dragonstone", summary: loremipum, date: formatter.date(from: "2017-07-16 00:00:00")!, image: #imageLiteral(resourceName: "s7e1.jpg"), season: season7),
            Episode(id: 72, title: "Stormborn", summary: loremipum, date: formatter.date(from: "2017-07-23 00:00:00")!, image: #imageLiteral(resourceName: "s7e2.jpg"), season: season7),
            Episode(id: 73, title: "The Queen's Justice", summary: loremipum, date: formatter.date(from: "2017-07-30 00:00:00")!, image: #imageLiteral(resourceName: "s7e3.jpg"), season: season7))
        
        _seasons = [season1, season2, season3, season4, season5, season6, season7]
    }
    
    var houses: [House] {
        return _houses.sorted()
    }
    
    func house(name: String) -> House? {
        return houses.filter{ $0.name.uppercased() == name.uppercased() }.first
    }
    
    func house(name: HouseKey) -> House? {
        return houses.filter{ $0.name.uppercased() == name.rawValue.uppercased() }.first
    }
    
    func houses(filteredBy: FilterHouse) -> [House] {
        return houses.filter(filteredBy)
    }
    
    var seasons: [Season] {
        return _seasons.sorted();
    }
    
    func season(name: String) -> Season? {
        return seasons.filter{ $0.name.uppercased() == name.uppercased() }.first
    }
    
    func seasons(filteredBy: FilterSeason) -> [Season] {
        return seasons.filter(filteredBy)
    }
}
