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
    let name: String
    let sigil: Sigil
    let words: Words
    
    private var _members: Members
    
    init(name: String, sigil: Sigil, words: Words) {
        self.name = name
        self.sigil = sigil
        self.words = words
        
        _members = Members()
    }
}

// MARK: - Members
extension House {
    var count: Int {
        return _members.count
    }
    
    func add(person: Person) {
        guard person.house == self else {
            return
        }
        
        _members.insert(person)
    }
}

// MARK: - Proxy
extension House {
    var proxyForEquatable: String {
        return "\(name) \(words) \(count)"
    }
    
    var proxyForComparison: String {
        return name.uppercased()
    }
}

// MARK: - Equatable
extension House : Equatable {
    static func ==(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquatable == rhs.proxyForEquatable
    }
}

// MARK: - Hashable
extension House : Hashable {
    public var hashValue: Int {
        return proxyForEquatable.hashValue
    }
}

// MARK: - Comparable
extension House : Comparable {
    static func <(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
