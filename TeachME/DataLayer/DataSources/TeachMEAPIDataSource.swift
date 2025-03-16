//
//  TeachMEAPIDataSource.swift
//  TeachME
//
//  Created by TumbaDev on 4.03.25.
//

import Foundation

protocol TeachMEAPIDataSource: APIDataSource {}

extension TeachMEAPIDataSource {
    func fetchById(_ id: UUID) async throws -> DataType{
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "\(id)")
            .setMethod(.get)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL)/\(id) not found")
        }
        
        let fetchedData: Data
        do {
            (fetchedData, _) = try await client.request(request)
        } catch {
            throw DataSourceError.fetchingError("Values for id: \(id) could not be fetched!")
        }
        
        let data: DataType
        do {
            data = try decoder.decode(DataType.self, from: fetchedData)
        } catch {
            throw DataSourceError.decodingError("Data for id: \(id) could not be decoded!")
        }
        
        return data
    }
    
    func update(_ data: DataType) async throws where DataType: Identifiable {
        let jsonData: Data
        do {
            jsonData = try encoder.encode(data)
        } catch {
            throw DataSourceError.encodingError("Data of \(data) could not be encoded!")
        }
        
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "\(data.id)")
            .setMethod(.put)
            .setHeaders(["Content-Type": "application/json"])
            .setBody(jsonData)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL)/\(data.id) not found")
        }

        do {
            let _ = try await client.request(request)
        } catch {
            throw DataSourceError.updatingError("Data of \(data) could not be updated!")
        }
    }

    
    func delete(_ id: UUID) async throws {
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "\(id)")
            .setMethod(.delete)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL)/\(id) not found")
        }

        do {
            let _ = try await client.request(request)
        } catch {
            throw DataSourceError.deletingError("Data with ID \(id) could not be deleted!")
        }
    }
    
    func fetchAll() async throws -> [DataType] {
        guard let request = try URLRequestBuilder(baseURL: baseURL)
            .setMethod(.get)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL) not found")
        }
        
        let fetchedData: Data
        do {
            (fetchedData, _) = try await client.request(request)
        } catch {
            throw DataSourceError.fetchingError("Values on url: \(baseURL) could not be fetched!")
        }
        
        let data: [DataType]
        do {
            data = try decoder.decode([DataType].self, from: fetchedData)
        } catch {
            throw DataSourceError.decodingError("Value on url: \(baseURL) could not be decoded!")
        }
        
        return data
    }
}
