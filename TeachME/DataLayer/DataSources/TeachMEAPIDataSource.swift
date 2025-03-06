//
//  TeachMEAPIDataSource.swift
//  TeachME
//
//  Created by TumbaDev on 4.03.25.
//

import Foundation

protocol TeachMEAPIDataSource: APIDataSource {}

extension TeachMEAPIDataSource {
    func create(_ data: DataType) async throws -> DataType {
        let jsonData: Data
        do {
           jsonData = try encoder.encode(data)
        } catch {
           throw DataSourceError.encodingError("Data of \(data) could not be encoded!")
        }
        
        guard let request = URLRequestBuilder(baseURL: url)
            .setMethod(.post)
            .setHeaders(["application/json": "Content-Type"])
            .setBody(jsonData)
            .build()
        else {
            throw DataSourceError.invalidURL("\(url) not found")
        }

        let returnedData: Data
        do {
            (returnedData, _) = try await client.request(request)
        } catch {
           throw DataSourceError.postingError("Data of \(data) could not be created!")
        }
        
        let createdData: DataType
        do {
            createdData = try decoder.decode(DataType.self, from: returnedData)
        } catch {
            throw DataSourceError.decodingError("Data of \(data) could not be decoded!")
        }
        
        return createdData
    }
    
    func fetchById(_ id: UUID) async throws -> DataType{
        guard let request = URLRequestBuilder(baseURL: url, path: "\(id)")
            .setMethod(.get)
            .build()
        else {
            throw DataSourceError.invalidURL("\(url)/\(id) not found")
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
    
    func update(_ data: DataType) async throws {
        let jsonData: Data
        do {
            jsonData = try encoder.encode(data)
        } catch {
            throw DataSourceError.encodingError("Data of \(data) could not be encoded!")
        }
        
        guard let request = URLRequestBuilder(baseURL: url, path: "\(data.id)")
            .setMethod(.put)
            .setHeaders(["application/json": "Content-Type"])
            .setBody(jsonData)
            .build()
        else {
            throw DataSourceError.invalidURL("\(url)/\(data.id) not found")
        }

        do {
            let _ = try await client.request(request)
        } catch {
            throw DataSourceError.updatingError("Data of \(data) could not be updated!")
        }
    }

    
    func delete(_ id: UUID) async throws {
        guard let request = URLRequestBuilder(baseURL: url, path: "\(id)")
            .setMethod(.delete)
            .build()
        else {
            throw DataSourceError.invalidURL("\(url)/\(id) not found")
        }

        do {
            let _ = try await client.request(request)
        } catch {
            throw DataSourceError.deletingError("Data with ID \(id) could not be deleted!")
        }
    }
    
    func fetchAll() async throws -> [DataType] {
        guard let request = URLRequestBuilder(baseURL: url)
            .setMethod(.get)
            .build()
        else {
            throw DataSourceError.invalidURL("\(url) not found")
        }
        
        let fetchedData: Data
        do {
            (fetchedData, _) = try await client.request(request)
        } catch {
            throw DataSourceError.fetchingError("Values on url: \(url) could not be fetched!")
        }
        
        let data: [DataType]
        do {
            data = try decoder.decode([DataType].self, from: fetchedData)
        } catch {
            throw DataSourceError.decodingError("Value on url: \(url) could not be decoded!")
        }
        
        return data
    }
}
