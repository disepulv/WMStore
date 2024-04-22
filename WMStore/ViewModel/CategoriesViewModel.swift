//
//  CategoriesViewModel.swift
//  WMStore
//
//  Created by Diego Sepulveda on 21-04-24.
//

import SwiftUI

public class CategoriesViewModel: ObservableObject {

    @Published var categories: [String]?

    @Published var showCategories = false

    @AppStorage("selectedCategory") var selectedCategory: String = ""

    private let service: APIService

    init(service: APIService = WMAPIService.shared) {
        self.service = service
    }

    @MainActor
    func fetchCategories() {
        Task {
            do {
                let fetchedCategories = try await service.fetchCategories()
                self.categories = fetchedCategories
            } catch {
                print(error)
            }
        }
    }

}
