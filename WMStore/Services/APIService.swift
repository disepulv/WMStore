//
//  APIServices.swift
//  WMStore
//
//  Created by Diego Sepulveda on 19-04-24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case decodingError
    case custom(errorMessage: String)
}

public protocol APIService {
    static var shared: APIService { get }
    var baseURL: String { get set }
    var session: URLSession { get set }

    func fetchProducts() async throws -> [Product]
    func fetchProductsBy(category: String) async throws -> [Product]
    func fetchCategories() async throws -> [String]
    func fetchProduct(productID: Int) async throws -> Product
}

public class WMAPIService: APIService {

    public var baseURL = "https://fakestoreapi.com"

    public var session: URLSession
    
    public static var shared: APIService = WMAPIService()

    init(
        session: URLSession = URLSession.shared
    ) {
        self.session = session
    }

    public func fetchProducts() async throws -> [Product] {
        guard let url = URL(string: baseURL + "/products") else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await session.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        let fetchedProducts = try JSONDecoder().decode([Product].self, from: data)

        return fetchedProducts
    }

    public func fetchProductsBy(category: String) async throws -> [Product] {
        let category = category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        guard let url = URL(string: baseURL + "/products/category/" + category) else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await session.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        let fetchedProducts = try JSONDecoder().decode([Product].self, from: data)

        return fetchedProducts
    }

    public func fetchCategories() async throws -> [String] {
        guard let url = URL(string: baseURL + "/products/categories") else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await session.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        let fetchedCategories = try JSONDecoder().decode([String].self, from: data)

        return fetchedCategories
    }

    public func fetchProduct(productID: Int) async throws -> Product {
        guard let url = URL(string: baseURL + "/products/\(productID)") else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await session.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        let fetchedProduct = try JSONDecoder().decode(Product.self, from: data)

        return fetchedProduct
    }
}
