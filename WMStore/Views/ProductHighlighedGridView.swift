//
//  ProductHighlighedGridView.swift
//  WMStore
//
//  Created by Diego Sepulveda on 22-04-24.
//

import SwiftUI

struct ProductHighlighedGridView: View {
    @Environment(\.modelContext) var modelContext

    var product: Product!

    var body: some View {
        HStack {
            GeometryReader { geometry in
                AsyncImage(url: URL(string: product.image ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView() // Placeholder while loading
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height) // Set size dynamically
                    case .failure:
                        Image(systemName: "xmark.circle") // Placeholder on failure
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .frame(width: 100, height: 100) // Set initial frame size
            .clipped()
            .padding()
            .border(.gray)

            VStack(alignment: .leading) {
                Text("Highlighed")
                    .bold()
                Text(product.title ?? "No title")
                    .lineLimit(1, reservesSpace: true)
                
                Text("$ \(product.priceFormatted)")

                HStack(spacing: 10) {

                    Spacer()
                    Button(action: {
                        let cart = Cart(product: product)
                        modelContext.insert(cart)
                    }, label: {
                        Image(systemName: "plus.circle")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                    })
                }
            }
            .padding()
        }
        .padding()
        .border(.gray)
    }
}

#Preview {
    let jsonData = """
        {"id":1,
        "title":"Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
        "price":109.95,
        "description":"Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
        "category":"men's clothing",
        "image":"https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
        "rating":{"rate":3.9,"count":120}
        }
        """.data(using: .utf8)!

    do {
        let product = try JSONDecoder().decode(Product.self, from: jsonData)
        return ProductHighlighedGridView(product: product)
    } catch {
        // Handle error if decoding fails
        fatalError("Failed to decode JSON: \(error)")
    }
}
