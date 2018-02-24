//
//  House.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 08/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import Foundation

typealias Words = String
typealias Members = Set<Person>


// MARK: - House
final class House {
    let id: Int
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiURL: URL
    
    private var _members: Members
    
    init(id: Int, name: String, sigil: Sigil, words: Words, url: URL) {
        self.id = id
        self.name = name
        self.sigil = sigil
        self.words = words
        self.wikiURL = url
        
        _members = Members()
    }
}

// MARK: - Members
extension House {
    var count: Int {
        return _members.count
    }
    
    var members: [Person] {
        return _members.sorted()
    }
    
    func add(person: Person) {
        guard person.house == self else {
            return
        }
        
        _members.insert(person)
    }
    
    func add(persons: Person...) {
        persons.forEach { add(person: $0) }
    }
}

// MARK: - Proxy
extension House {
    var proxy: Int {
        return id
    }
    
    var proxyForComparison: String {
        return name.uppercased()
    }
}

// MARK: - Equatable
extension House : Equatable {
    static func ==(lhs: House, rhs: House) -> Bool {
        return lhs.proxy == rhs.proxy
    }
}

// MARK: - Hashable
extension House : Hashable {
    public var hashValue: Int {
        return proxy.hashValue
    }
}

// MARK: - Comparable
extension House : Comparable {
    static func <(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
