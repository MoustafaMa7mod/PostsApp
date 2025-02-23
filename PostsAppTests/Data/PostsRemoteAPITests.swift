//
//  PostsRemoteAPITests.swift
//  PostsAppTests
//
//  Created by Moustafa on 24/02/2025.
//

import XCTest
@testable import NetworkLayer
@testable import PostsApp

final class PostsRemoteAPITests: XCTestCase {

    var mockNetworkService: MockNetworkService!
    var networkService: NetworkService!
    var postsRemoteAPI: PostsRemoteAPIProtocol!

    override func setUp() {
        super.setUp()
        
        mockNetworkService = MockNetworkService()
        networkService = NetworkService(session: mockNetworkService, baseURL: "")
        postsRemoteAPI = PostsRemoteAPI(networkService: networkService)
    }
    
    override func tearDown() {
        mockNetworkService = nil
        networkService = nil
        postsRemoteAPI = nil
        super.tearDown()
    }

    
    func testFetchPosts_Success() async throws {
        let mockData = """
            [
                { "userId": 1, "id": 1, "title": "post title", "body": "post body" },
                { "userId": 2, "id": 2, "title": "post title", "body": "post body" },
                { "userId": 3, "id": 3, "title": "post title", "body": "post body" }
            ]
            """.data(using: .utf8)
        
        let mockResponse = HTTPURLResponse(
            url: URL(string: "https://api.example.com/")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        mockNetworkService.mockData = mockData
        mockNetworkService.mockResponse = mockResponse
        
        let result = try await postsRemoteAPI.fetchPosts()
        
        XCTAssertEqual(result.count, 3)
    }
    
    func testFetchPosts_DecodeFailure() async throws {
        let mockData = """
            [
                { "userId": 1, "id": "1", "title": "post title", "body": "post body" },
                { "userId": 2, "id": 2, "title": "post title", "body": "post body" },
                { "userId": "3", "id": 3, "title": "post title", "body": "post body" }
            ]
            """.data(using: .utf8)
        
        let mockResponse = HTTPURLResponse(
            url: URL(string: "https://api.example.com/")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        mockNetworkService.mockData = mockData
        mockNetworkService.mockResponse = mockResponse
        
        do {
            // When: Call API with invalid JSON
            _ = try await postsRemoteAPI.fetchPosts()
            XCTFail("Expected decoding error, but no error was thrown.")
        } catch let error as APIError {
            // Then: Ensure it throws a decoding error
            XCTAssertEqual(error, APIError.decodingError)
        }
    }
}
