//
//  NetworkLayerTests.swift
//  NetworkLayer
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest
@testable import NetworkLayer

final class NetworkLayerTests: XCTestCase {
    
    var networkService: NetworkService!
    var mockSession: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        
        mockSession = MockNetworkService()
        networkService = NetworkService(
            session: mockSession,
            baseURL: "https://api.example.com/",
            apiKey: "test_api_key"
        )
    }
    
    override func tearDown() {
        networkService = nil
        mockSession = nil
        super.tearDown()
    }
    
    /// Test successful API response
    func testFetchData_Success() async throws {
        let expectedResponse = MockResponse(message: "Success")
        let jsonData = try JSONEncoder().encode(expectedResponse)

        mockSession.mockData = jsonData
        mockSession.mockResponse = HTTPURLResponse(
            url: URL(string: "https://api.example.com/test")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let result: MockResponse = try await networkService.fetchData(
            urlString: "test?",
            query: "param=value"
        )

        XCTAssertEqual(result, expectedResponse, "Decoded response should match expected")
    }
    
    /// Test invalid URL error handling
    func testFetchData_InvalidURL() async {
        
        do {
            let _: MockResponse = try await networkService.fetchData(
                urlString: "",
                query: "param=value"
            )
            
            XCTFail("Expected APIError.invalidURL but got success instead")
        } catch let error as APIError {
            XCTAssertEqual(
                error,
                .invalidResponse,
                "Should throw APIError.invalidURL for an empty URL"
            )
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }

    /// Test non-200 HTTP response error handling
    func testFetchData_InvalidResponse() async {
        mockSession.mockResponse = HTTPURLResponse(
            url: URL(string: "https://api.example.com/test")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )

        do {
            let _: MockResponse = try await networkService.fetchData(
                urlString: "test?",
                query: "param=value"
            )
            
            XCTFail("Expected invalidResponse error but got success")
        } catch {
            XCTAssertEqual(
                error as? APIError,
                APIError.invalidResponse,
                "Should throw invalidResponse error"
            )
        }
    }

    /// Test JSON decoding failure
    func testFetchData_DecodingError() async {
        mockSession.mockData = "Invalid JSON".data(using: .utf8)
        mockSession.mockResponse = HTTPURLResponse(
            url: URL(string: "https://api.example.com/test")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        do {
            let _: MockResponse = try await networkService.fetchData(
                urlString: "test?",
                query: "param=value"
            )
            
            XCTFail("Expected decodingError but got success")
        } catch {
            XCTAssertEqual(
                error as? APIError,
                APIError.decodingError,
                "Should throw decodingError"
            )
        }
    }
}
