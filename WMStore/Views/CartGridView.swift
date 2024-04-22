//
//  CardGridView.swift
//  WMStore
//
//  Created by Diego Sepulveda on 21-04-24.
//

import SwiftUI

struct CartGridView: View {

    @Environment(\.modelContext) var modelContext
    @State private var quantity: Int
    var cart: Cart!

    init(cart: Cart) {
        self.cart = cart
        self.quantity = cart.quantity
    }

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: cart.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Image(systemName: "xmark.circle")
                @unknown default:
                    EmptyView()
                }
            }
            .frame(maxWidth: 100)
            .frame(height: 100)
            .clipped()
            .border(.gray)
            .padding()

            VStack(spacing: 10) {
                VStack (alignment: .leading) {
                    Text(cart.title)
                        .lineLimit(1, reservesSpace: true)
                        .multilineTextAlignment(.leading)
                        .bold()
                    Text("$ \(cart.priceFormatted)")
                        .multilineTextAlignment(.leading)
                }

                Button("Delete") {
                    modelContext.delete(cart)
                }
                .buttonStyle(.borderedProminent)

                VStack {
                    HStack {
                        Text("\(quantity) un")
                            .font(.headline)
                        Stepper("", value: $quantity, in: 1...10)
                            .onChange(of: quantity) { oldValue, newValue in
                                cart.quantity = newValue
                            }
                    }
                    .padding()
                }


            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    let cart = Cart(id: 0,
                    title: "Title",
                    price: 99.9,
                    image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                    quantity: 5)
    return CartGridView(cart: cart)
}
