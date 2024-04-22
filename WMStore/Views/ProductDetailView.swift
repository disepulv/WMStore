//
//  DetailView.swift
//  WMStore
//
//  Created by Diego Sepulveda on 20-04-24.
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(\.modelContext) var modelContext

    @ObservedObject var viewModel: ProductDetailViewModel

    var productID: Int!

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    AsyncImage(url: URL(string: viewModel.product?.image ?? "")) { phase in
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
                    .frame(maxWidth: 300)
                    .frame(height: 300)
                    .clipped()
                    .border(.black)

                    HStack(spacing: 10) {
                        Text(viewModel.product?.title ?? "No title")
                            .lineLimit(1, reservesSpace: true)
                            .bold()
                        Spacer()
                        Text("$ \(viewModel.product?.priceFormatted ?? "")")
                    }
                    .padding()

                    Text(viewModel.product?.description ?? "No desc")
                        .lineLimit(5, reservesSpace: true)
                        .padding()

                    HStack {
                        ForEach(0...4, id: \.self) { index in
                            Image(systemName: index < Int(viewModel.product?.rating?.rate?.rounded() ?? 0) ? "star.fill": "star")
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                        }
                        Spacer()
                        Button(action: {
                            let cart = Cart(product: viewModel.product!)
                            modelContext.insert(cart)
                            viewModel.showProductDetail = false
                        }, label: {
                            Image(systemName: "plus.circle")
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                        })
                    }
                }

                if viewModel.product == nil {
                    ProgressView {
                        Text("Loading...")
                    }
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchProduct(productID: productID)
        }
        .navigationTitle("Detail")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.showProductDetail = false
                } label: {
                    Image(systemName: "xmark.circle")
                }
            }
        }



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
        let model = ProductDetailViewModel()
        model.product = product

        return ProductDetailView(viewModel: model, productID: 1)
    } catch {
        fatalError("Failed to decode JSON: \(error)")
    }
}
