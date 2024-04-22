//
//  CartView.swift
//  WMStore
//
//  Created by Diego Sepulveda on 20-04-24.
//

import SwiftUI
import SwiftData

struct CartView: View {

    @Query var cart: [Cart]
    @State private var purchaseAlert = false

    var total: Double {
        cart.reduce(0) {  partialResult, nextCart  in
            return partialResult + nextCart.total
        }
    }

    var body: some View {
        ZStack {
            VStack {
                Text("Cart")
                    .font(.largeTitle)
                    .bold()

                List {
                    ForEach(cart, id: \.self) { cart in
                        CartGridView(cart: cart)
                            .frame(height: 200)
                    }
                }

                Text("Total: $\(String(format: "%.2f", total)) CLP")
                    .bold()

                Button("Purchase") {
                    purchaseAlert = true
                }
                .alert("Thanks for your purchase", isPresented: $purchaseAlert) {
                    Button("OK", role: .cancel) { }
                }
                .buttonStyle(.borderedProminent)

            }
            .padding()

            if cart.isEmpty {
                Text("Empty cart")
            }
        }
        .padding(.top, 1)
        .badge(cart.count)

    }
}

#Preview {
    CartView()
}
