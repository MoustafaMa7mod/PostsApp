//
//  NetworkAPIErrors.swift
//  NetworkLayer
//
//  Created by Mostafa Mahmoud on 21/02/2025.
//

/// `APIError` defines possible errors that can occur during a network request.
/// It conforms to the `Error` protocol, making it throwable in network operations.
///
public enum APIError: Error, Equatable {
    
    /// Indicates that the provided URL is invalid or malformed.
    case invalidURL
    
    /// Represents a failure in the network request, such as no internet connection.
    case requestFailed
    
    /// Indicates that the server response was invalid (e.g., non-200 status codes).
    case invalidResponse
    
    /// Occurs when the received data cannot be decoded into the expected model.
    case decodingError
}
