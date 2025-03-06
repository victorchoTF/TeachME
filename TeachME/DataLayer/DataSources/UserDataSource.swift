//
//  UserDataSource.swift
//  TeachME
//
//  Created by TumbaDev on 2.03.25.
//

import Foundation

final class UserTypeDataSource: TeachMEAPIDataSource {
    typealias DataType = UserDTO
    
    let client: HTTPClient
    let url: String
    let encoder: JSONEncoder
    let decoder: JSONDecoder
    
    init(client: HTTPClient, url: String, encoder: JSONEncoder, decoder: JSONDecoder) {
        self.client = client
        self.url = url
        self.encoder = encoder
        self.decoder = decoder
    }
    
    func getUsersByRoleId(_ id: UUID) async throws -> [UserDTO] {
        guard let request = URLRequestBuilder(baseURL: url, path: "list/\(id)")
            .setMethod(.get)
            .build()
        else {
            throw DataSourceError.invalidURL("\(url)/list/\(id) not found")
        }
        
        let fetchedData: Data
        do {
            (fetchedData, _) = try await client.request(request)
        } catch {
            throw DataSourceError.fetchingError("Users for roleId: \(id) could not be fetched!")
        }
        
        let data: [UserDTO]
        do {
            data = try decoder.decode([UserDTO].self, from: fetchedData)
        } catch {
            throw DataSourceError.decodingError("Users for roleId: \(id) could not be decoded!")
        }
        
        return data
    }
}
