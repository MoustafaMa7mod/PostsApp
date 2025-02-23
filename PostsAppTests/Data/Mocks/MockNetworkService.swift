//
//  MockNetworkService.swift
//  PostsApp
//
//  Created by Moustafa on 24/02/2025.
//

import Foundation
@testable import NetworkLayer

class MockNetworkService: URLSessionProtocol {
    
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    
    public func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        
        guard let data = mockData, let response = mockResponse else {
            throw APIError.invalidResponse
        }
        
        return (data, response)
    }
}
