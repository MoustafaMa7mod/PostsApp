//
//  URLSession.swift
//  NetworkLayer
//
//  Created by Mostafa Mahmoud on 21/02/2025.
//

import Foundation

public protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
