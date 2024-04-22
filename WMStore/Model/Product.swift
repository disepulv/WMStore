//
//  Product.swift
//  WMStore
//
//  Created by Diego Sepulveda on 19-04-24.
//

import Foundation

public struct Product: Codable, Hashable {
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: String?
    let image: String?
    let rating: Rating?
    var priceFormatted: String {
        String(format: "%.2f", price ?? 0.0)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case price = "price"
        case description = "description"
        case category = "category"
        case image = "image"
        case rating = "rating"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        rating = try values.decodeIfPresent(Rating.self, forKey: .rating)
    }
}
