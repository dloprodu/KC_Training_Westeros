//
//  Episode.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 21/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import Foundation

final class Episode {
    let id: Int
    let title: String
    let releaseDate: Date
    weak var season: Season?
    
    init(id: Int, title: String, date: Date, season: Season) {
        self.id = id
        self.title = title
        self.releaseDate = date
        self.season = season
    }
}

// MARK: - Proxies
extension Episode {
    fileprivate var proxy: Int {
        return id
    }
    
    fileprivate var proxyForComparison: Date {
        return releaseDate
    }
}

// MARK: - CustomStringConvertible
extension Episode : CustomStringConvertible {
    var description: String {
        return "\(title)"
    }
}

// MARK: - Equatable
extension Episode : Equatable {
    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxy == rhs.proxy
    }
}

// MARK: - Hashable
extension Episode : Hashable {
    public var hashValue: Int {
        return proxy.hashValue
    }
}

// MARK: - Comparable
extension Episode: Comparable {
    static func <(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}