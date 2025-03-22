//
//  UserDataSource.swift
//  TeachME
//
//  Created by TumbaDev on 2.03.25.
//

import Foundation

final class UserDataSource: TeachMEAPIDataSource {
    typealias DataType = UserDTO
    
    let client: HTTPClient
    let baseURL: String
    let encoder: JSONEncoder
    let decoder: JSONDecoder
    
    init(client: HTTPClient, baseURL: String, encoder: JSONEncoder, decoder: JSONDecoder) {
        self.client = client
        self.baseURL = baseURL
        self.encoder = encoder
        self.decoder = decoder
    }
    
    func update(_ body: UserBodyDTO, id: UUID) async throws {
        let jsonBody: Data
        do {
            jsonBody = try encoder.encode(body)
        } catch {
            throw DataSourceError.encodingError("Body of \(body) could not be encoded!")
        }
        
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "\(id)")
            .setMethod(.put)
            .useJsonContentType()
            .setBody(jsonBody)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL)/\(id) not found")
        }

        do {
            let _ = try await client.request(request)
        } catch {
            throw DataSourceError.updatingError("Data of \(body) could not be updated!")
        }
    }
    
    func fetchByEmail(_ email: String) async throws -> UserDTO {
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "email/\(email)")
            .setMethod(.get)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL)/\(email) not found")
        }
        
        let fetchedData: Data
        do {
            (fetchedData, _) = try await client.request(request)
        } catch {
            throw DataSourceError.fetchingError(
                "Values for email: \(email) could not be fetched!"
            )
        }
        
        let data: DataType
        do {
            data = try decoder.decode(DataType.self, from: fetchedData)
        } catch {
            throw DataSourceError.decodingError("Data for email: \(email) could not be decoded!")
        }
        
        return data
    }
    
    func getUsersByRoleId(_ id: UUID) async throws -> [UserDTO] {
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "list/\(id)")
            .setMethod(.get)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL)/list/\(id) not found")
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
