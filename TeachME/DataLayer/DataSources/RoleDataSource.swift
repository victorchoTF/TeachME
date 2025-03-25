//
//  RoleDataSource.swift
//  TeachME
//
//  Created by TumbaDev on 2.03.25.
//

import Foundation

final class RoleDataSource: TeachMEAPIDataSource {
    typealias DataType = RoleDTO
    
    let client: HTTPClient
    let baseURL: String
    let encoder: JSONEncoder
    let decoder: JSONDecoder
    
    private let fetchAllURL: String
    
    init(
        client: HTTPClient,
        baseURL: String,
        encoder: JSONEncoder,
        decoder: JSONDecoder,
        fetchAllURL: String
    ) {
        self.client = client
        self.baseURL = baseURL
        self.encoder = encoder
        self.decoder = decoder
        self.fetchAllURL = fetchAllURL
    }
    
    func fetchAll() async throws -> [DataType] {
        guard let request = try URLRequestBuilder(baseURL: fetchAllURL)
            .setMethod(.get)
            .build()
        else {
            throw DataSourceError.invalidURL("\(fetchAllURL) not found")
        }
        
        let fetchedData: Data
        do {
            (fetchedData, _) = try await client.request(request)
        } catch {
            throw DataSourceError.fetchingError(
                "Values on url: \(fetchAllURL) could not be fetched!"
            )
        }
        
        let data: [DataType]
        do {
            data = try decoder.decode([DataType].self, from: fetchedData)
        } catch {
            throw DataSourceError.decodingError("Value on url: \(fetchAllURL) could not be decoded!")
        }
        
        return data
    }
}
