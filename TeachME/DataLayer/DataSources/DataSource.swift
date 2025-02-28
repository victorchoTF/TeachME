//
//  DataSource.swift
//  TeachME
//
//  Created by TumbaDev on 28.02.25.
//

import Foundation

protocol DataSource {
    associatedtype DataType: DataModel
    
    var client: HTTPClient { get }
    var url: URL { get }
    
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
    
    func create(_ data: DataType) async throws
    func fetchById(_ id: UUID) async throws -> DataType
    func update(_ data: DataType) async throws
    func delete(_ id: UUID) async throws
    func fetchAll() async throws -> [DataType]
}

extension DataSource {
    func create(_ data: DataType) async throws {
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
           let jsonData = try encoder.encode(data)
           request.httpBody = jsonData
        } catch {
           throw DataSourceError.encodingError("Data of \(data) could not be encoded!")
        }

        do {
           let _ = try await client.request(request)
        } catch {
           throw DataSourceError.postingError("Data of \(data) could not be created!")
        }
    }
    
    func fetchById(_ id: UUID) async throws -> DataType{
        var request = URLRequest(url: url.appendingPathComponent("\(id)"))
        
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
        var request = URLRequest(url: url.appendingPathComponent("\(data.id)"))
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try encoder.encode(data)
            request.httpBody = jsonData
        } catch {
            throw DataSourceError.encodingError("Data of \(data) could not be encoded!")
        }

        do {
            let _ = try await client.request(request)
        } catch {
            throw DataSourceError.updatingError("Data of \(data) could not be updated!")
        }
    }

    
    func delete(_ id: UUID) async throws {
        var request = URLRequest(url: url.appendingPathComponent("\(id)"))
        request.httpMethod = "DELETE"

        do {
            let _ = try await client.request(request)
        } catch {
            throw DataSourceError.deletingError("Data with ID \(id) could not be deleted!")
        }
    }
    
    func fetchAll() async throws -> [DataType] {
        var request = URLRequest(url: url)
        
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
