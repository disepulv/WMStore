//
//  ProductDetailModelViewTest.swift
//  WMStoreTests
//
//  Created by Diego Sepulveda on 21-04-24.
//

import XCTest
@testable import WMStore

final class APIServiceTest: XCTestCase {

    var mockAPIService: APIService!
    var session: URLSession!

    override func setUp() {
            super.setUp()
            // Set up URLSession with MockURLProtocol
            session = {
                let configuration = URLSessionConfiguration.ephemeral
                configuration.protocolClasses = [MockURLProtocol.self]
                return URLSession(configuration: configuration)
            }()

            mockAPIService = WMAPIService(session: session)
        }

    override func tearDown() {
        mockAPIService = nil
        session = nil
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }

    func testFetchProductSuccess() async throws {
        let mockData = """
            {"id":1,
            "title":"Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
            "price":109.95,
            "description":"Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
            "category":"men's clothing",
            "image":"https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
            "rating":{"rate":3.9,"count":120}
            }
            """.data(using: .utf8)!

        MockURLProtocol.requestHandler = { request in
            // Assert that the request is made to the correct endpoint
            XCTAssertEqual(request.url?.absoluteString, "https://fakestoreapi.com/products/1")

            // Return a mocked response
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, mockData)
        }

        // Act
        let product = try await mockAPIService.fetchProduct(productID: 1)

        // Assert
        XCTAssertNotNil(product)
        XCTAssertTrue(product.id == 1)
        XCTAssertTrue(product.price == 109.95)
    }

    func testFetchCategoriesSuccess() async throws {
        let mockData = """
            ["electronics","jewelery","men's clothing","women's clothing"]
            """.data(using: .utf8)!

        MockURLProtocol.requestHandler = { request in
            // Assert that the request is made to the correct endpoint
            XCTAssertEqual(request.url?.absoluteString, "https://fakestoreapi.com/products/categories")

            // Return a mocked response
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, mockData)
        }

        // Act
        let categories = try await mockAPIService.fetchCategories()

        // Assert
        XCTAssertNotNil(categories)
        XCTAssertTrue(categories.count == 4)
    }

}
