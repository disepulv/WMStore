//
//  MainView.swift
//  WMStore
//
//  Created by Diego Sepulveda on 20-04-24.
//

import SwiftUI
import SwiftData

struct MainView: View {

    @AppStorage("selectedCategory") var selectedCategory: String = ""

    @Query var cart: [Cart]

    let appearance: UITabBarAppearance = UITabBarAppearance()

    init() {
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView() {
            ProductsView(productsViewModel: ProductsViewModel(),
                         productDetailViewModel: ProductDetailViewModel(),
                         categoriesViewModel: CategoriesViewModel())
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(1)

            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .tag(2)
        }
        //.navigationTitle(selection == 1 ? "My super App" : "Cart")
        /*.navigationTitle("My super App")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.showCategories.toggle()
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }*/
    }
}

#Preview {
    MainView()
}
