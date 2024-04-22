//
//  Cart.swift
//  WMStore
//
//  Created by Diego Sepulveda on 21-04-24.
//

import SwiftData

@Model
class Cart {
    @Attribute(.unique) let id: Int
    let title: String
    let price: Double
    let image: String
    var quantity: Int

    var total: Double {
        price * Double(quantity)
    }

    var priceFormatted: String {
        String(format: "%.2f", price)
    }

    init(id: Int, title: String, price: Double, image: String, quantity: Int) {
        self.id = id
        self.title = title
        self.price = price
        self.image = image
        self.quantity = quantity
    }

    init(product: Product) {
        self.id = product.id ?? 0
        self.title = product.title ?? ""
        self.price = product.price ?? 0.0
        self.image = product.image ?? ""
        self.quantity = 1
    }
}
