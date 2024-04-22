//
//  ProductDetailViewModel.swift
//  WMStore
//
//  Created by Diego Sepulveda on 20-04-24.
//

import SwiftUI

public class ProductDetailViewModel: ObservableObject {

    @Published var product: Product?

    @Published var showProductDetail = false

    private let service: APIService

    init(service: APIService = WMAPIService.shared) {
        self.service = service
    }

    @MainActor
    public func fetchProduct(productID: Int) {
        Task {
            do {
                let fetchedProduct = try await service.fetchProduct(productID: productID)
                self.product = fetchedProduct
            } catch {
                print(error)
            }
        }
    }

}
