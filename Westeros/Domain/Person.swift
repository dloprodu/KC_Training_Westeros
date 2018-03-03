//
//  Character.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 08/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import Foundation

final class Person {
    let id: Int
    let name: String
    weak var house: House?
    
    private let _alias: String?
    var alias: String {
        return _alias ?? ""
    }
    
    init(id: Int, name: String, alias: String? = nil, house: House) {
        self.id = id
        self.name = name
        self._alias = alias
        self.house = house
        
        // self.house?.add(person: self)
    }
}

extension Person {
    var fullName: String {
        guard let house = house else {
            return "\(name)"
        }
        
        return "\(name) \(house.name)"
    }
}

// MARK: - Proxies
extension Person {
    fileprivate var proxy: Int {
        return id
    }
    
    var proxyForComparison: String {
        return "\(fullName)"
    }
}

// MARK: - CustomStringConvertible
extension Person : CustomStringConvertible {
    var description: String {
        return "\(fullName)"
    }
}

// MARK: - Equalable
extension Person : Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxy == rhs.proxy
    }
}

// MARK: - Hashable
extension Person : Hashable {
    public var hashValue: Int {
        return proxy.hashValue
    }
}

// MARK: - Comparable
extension Person: Comparable {
    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
