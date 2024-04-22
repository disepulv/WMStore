//
//  Rating.swift
//  WMStore
//
//  Created by Diego Sepulveda on 19-04-24.
//

import Foundation

struct Rating: Codable, Hashable {
    let rate: Double?
    let count: Int?
    var maxRating: Double {
        (rate ?? 0) * Double(count ?? 0)
    }
}
