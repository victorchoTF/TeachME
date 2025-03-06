//
//  URLRequestBuilder.swift
//  TeachME
//
//  Created by TumbaDev on 6.03.25.
//

import Foundation

class URLRequestBuilder {
    private var urlComponents: URLComponents
    private var method: HTTPMethod = .get
    private var headers: [String: String] = [:]
    private var body: Data?
    
    init(baseURL: String, path: String = "") {
        guard let components = URLComponents(string: baseURL + path) else {
            fatalError("Invalid URL")
        }
        self.urlComponents = components
    }
    
    func setMethod(_ method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    func addQueryItem(name: String, value: String) -> Self {
        var queryItems = urlComponents.queryItems ?? []
        queryItems.append(URLQueryItem(name: name, value: value))
        urlComponents.queryItems = queryItems
        return self
    }
    
    func setHeaders(_ headers: [String: String]) -> Self {
        self.headers = headers
        return self
    }
    
    func setBody(_ body: Data) -> Self {
        self.body = body
        return self
    }
    
    func build() -> URLRequest? {
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
}
