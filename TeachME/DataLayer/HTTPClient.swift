//
//  HTTPClient.swift
//  TeachME
//
//  Created by TumbaDev on 28.02.25.
//

import Foundation

protocol HTTPClient {
    func request(_ request: URLRequest) async throws -> (Data, HTTPURLResponse)
}

enum HTTPClientError: Error {
    case invalidResponse
}

enum HTTPClientNSError: Error {
    case cancelation
}

extension URLSession: HTTPClient {
    func request(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        do {
            let (data, response) = try await self.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTPClientError.invalidResponse
            }
            
            return (data, httpResponse)
            
        } catch let error as NSError {
            if error.code != NSURLErrorCancelled {
                throw error
            }
            
            throw HTTPClientNSError.cancelation
        } catch {
            throw error
        }
    }
}
