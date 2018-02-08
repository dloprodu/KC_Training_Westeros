//
//  Character.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 08/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import Foundation

final class Person {
    let name: String
    let house: House
    
    private let _alias: String?
    var alias: String {
        return _alias ?? ""
        /*
        get {
            if let _alias = _alias {
                return _alias
            } else {
                return ""
            }
        }
        */
    }
    
    init(name: String, alias: String? = nil, house: House) {
        self.name = name
        self._alias = alias
        self.house = house
    }
    
    //init(name: String, house: House) {
    //    self.name = name
    //    self.house = house
    //    self._alias = nil
    //}
}

extension Person {
    var fullName: String {
        return "\(name) \(house.name)"
    }
}

// MARK: - Proxies
extension Person {
    fileprivate var proxy: String {
        return "\(name) \(alias) \(house.name)"
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
