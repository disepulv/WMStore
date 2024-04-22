//
//  HomeViewModel.swift
//  WMStore
//
//  Created by Diego Sepulveda on 19-04-24.
//

import SwiftUI

public class ProductsViewModel: ObservableObject {
    @Published var products: [Product]?

    @AppStorage("selectedCategory") var selectedCategory: String = ""

    private let service: APIService

    init(service: APIService = WMAPIService.shared) {
        self.service = service
    }

    @MainActor 
    func fetchProducts() {
        if selectedCategory.isEmpty {
            fetchAllProducts()
        } else {
            fetchProductsBy(category: selectedCategory)
        }
    }

    @MainActor
    func fetchAllProducts() {
        Task {
            do {
                let fetchedProducts = try await service.fetchProducts()
                self.products = fetchedProducts.sorted(by: { $0.rating!.maxRating > $1.rating!.maxRating })
            } catch {
                print(error)
            }
        }
    }

    @MainActor 
    func fetchProductsBy(category: String) {
        Task {
            do {
                let fetchedProducts = try await service.fetchProductsBy(category: category)
                self.products = fetchedProducts.sorted(by: { $0.rating!.maxRating > $1.rating!.maxRating })
            } catch {
                print(error)
            }
        }
    }

}
