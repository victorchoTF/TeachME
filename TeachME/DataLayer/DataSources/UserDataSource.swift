//
//  UserDataSource.swift
//  TeachME
//
//  Created by TumbaDev on 2.03.25.
//

import Foundation

final class UserTypeDataSource: DataSource {
    typealias DataType = UserDTO
    
    var client: HTTPClient
    var url: URL
    var encoder: JSONEncoder
    var decoder: JSONDecoder
    
    init(client: HTTPClient, url: URL, encoder: JSONEncoder, decoder: JSONDecoder) {
        self.client = client
        self.url = url
        self.encoder = encoder
        self.decoder = decoder
    }
    
    func getUsersByRoleId(_ id: UUID) async throws -> [UserDTO] {
        let subURL = url.appendingPathComponent("list")
        
        var request = URLRequest(url: subURL.appendingPathComponent("\(id)"))
        
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
