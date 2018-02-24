//
//  Season.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 21/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>

final class Season {
    let id: Int
    let name: String
    let releaseDate: Date
    var _episodes: Episodes
    
    init(id: Int, name: String, date: Date) {
        self.id = id
        self.name = name
        self.releaseDate = date
        self._episodes = Episodes()
    }
}

// MARK: - Members
extension Season {
    var count: Int {
        return episodes.count
    }
    
    var episodes: [Episode] {
        return self._episodes.sorted()
    }
    
    func add(episode: Episode) {
        guard episode.season == self else {
            return
        }
        
        self._episodes.insert(episode)
    }
    
    func add(episodes: Episode...) {
        episodes.forEach { add(episode: $0) }
    }
}

// MARK: - Proxies
extension Season {
    fileprivate var proxy: Int {
        return id
    }
    
    fileprivate var proxyForComparison: Date {
        return releaseDate
    }
}

// MARK: - CustomStringConvertible
extension Season : CustomStringConvertible {
    var description: String {
        return "\(name) (\(releaseDate))"
    }
}

// MARK: - Equatable
extension Season : Equatable {
    static func ==(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxy == rhs.proxy
    }
}

// MARK: - Hashable
extension Season : Hashable {
    public var hashValue: Int {
        return proxy.hashValue
    }
}

// MARK: - Comparable
extension Season: Comparable {
    static func <(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
