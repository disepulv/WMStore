//
//  ContentView.swift
//  WMStore
//
//  Created by Diego Sepulveda on 19-04-24.
//

import SwiftUI

struct ProductsView: View {
    
    @ObservedObject var productsViewModel: ProductsViewModel
    @ObservedObject var productDetailViewModel: ProductDetailViewModel
    @ObservedObject var categoriesViewModel: CategoriesViewModel

    @AppStorage("selectedCategory") var selectedCategory: String = ""
    @AppStorage("selectedProduct") var selectedProduct: Int = 0

    var body: some View {
        VStack {
            HStack {
                Text("My super App")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Button(action: {
                    categoriesViewModel.showCategories.toggle()
                }, label: {
                    Image(systemName: "ellipsis.circle")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                })
            }.padding()
            ZStack {
                 let gridItems = [
                     GridItem(.fixed(150), spacing: 10, alignment: .leading),
                     GridItem(.fixed(150), spacing: 10, alignment: .leading)]

                 ScrollView(.vertical) {
                     LazyVGrid(columns: gridItems, spacing: 10) {
                         ForEach(Array((productsViewModel.products ?? []).enumerated()), id: \.1) { index, product in
                             ProductGridView(product: product)
                                 .frame(width: index == 0 ? 310 : 150, height: 200)
                                 .onTapGesture {
                                     selectedProduct = product.id ?? 0
                                     productDetailViewModel.showProductDetail.toggle()
                                 }

                             if index == 0 { Color.clear }
                         }
                     }
                 }

                 if productsViewModel.products == nil {
                     ProgressView {
                         Text("Loading...")
                     }
                 }
             }
        }
        .onChange(of: selectedCategory) {
            productsViewModel.products = nil
            productsViewModel.fetchProducts()
        }
        .sheet(isPresented: $categoriesViewModel.showCategories, content: {
            NavigationStack {
                CategoriesView(viewModel: categoriesViewModel, showCategories: $categoriesViewModel.showCategories)
            }
        })
        .sheet(isPresented: $productDetailViewModel.showProductDetail, content: {
            NavigationStack {
                ProductDetailView(viewModel: productDetailViewModel, productID: selectedProduct)
            }
        })
        .onAppear {
            productsViewModel.fetchProducts()
        }
    }
}

#Preview {
    ProductsView(productsViewModel: ProductsViewModel(),
                 productDetailViewModel: ProductDetailViewModel(),
                 categoriesViewModel: CategoriesViewModel())
}
