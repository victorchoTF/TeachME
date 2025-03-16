//
//  LessonTypeDataSource.swift
//  TeachME
//
//  Created by TumbaDev on 2.03.25.
//

import Foundation

final class LessonTypeDataSource: TeachMEAPIDataSource {
    typealias DataType = LessonTypeDTO
    
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
    
    func create(_ body: LessonTypeCreateBodyDTO) async throws -> LessonTypeDTO {
        let jsonBody: Data
        do {
           jsonBody = try encoder.encode(body)
        } catch {
           throw DataSourceError.encodingError("Body of \(body) could not be encoded!")
        }
        
        guard let request = try URLRequestBuilder(baseURL: baseURL)
            .setMethod(.post)
            .setHeaders(["Content-Type": "application/json"])
            .setBody(jsonBody)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL) not found")
        }

        let returnedBody: Data
        do {
            (returnedBody, _) = try await client.request(request)
        } catch {
           throw DataSourceError.postingError("Body of \(body) could not be created!")
        }
        
        let createdBody: LessonTypeDTO
        do {
            createdBody = try decoder.decode(LessonTypeDTO.self, from: returnedBody)
        } catch {
            throw DataSourceError.decodingError("Body of \(returnedBody) could not be decoded!")
        }
        
        return createdBody
    }
}
