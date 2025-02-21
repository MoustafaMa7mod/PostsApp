//
//  NetworkService.swift
//  NetworkLayer
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Foundation
@testable import NetworkLayer

public class MockNetworkService: URLSessionProtocol {
    
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
