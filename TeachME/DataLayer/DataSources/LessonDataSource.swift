//
//  LessonDataSource.swift
//  TeachME
//
//  Created by TumbaDev on 2.03.25.
//

import Foundation

final class LessonDataSource: TeachMEAPIDataSource {
    
    typealias DataType = LessonDTO
    
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
    
    func create(_ body: LessonBodyDTO) async throws -> LessonDTO {
        let jsonBody: Data
        do {
           jsonBody = try encoder.encode(body)
        } catch {
           throw DataSourceError.encodingError("CreateBody of \(body) could not be encoded!")
        }
        
        guard let request = try URLRequestBuilder(baseURL: baseURL)
            .setMethod(.post)
            .useJsonContentType()
            .setBody(jsonBody)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL) not found")
        }

        let returnedBody: Data
        let response: HTTPURLResponse
        do {
            (returnedBody, response) = try await client.request(request)
        } catch let error as NSError {
            throw error
        } catch {
           throw DataSourceError.postingError("CreateBody of \(body) could not be created!")
        }
        
        let createdBody: LessonDTO
        do {
            createdBody = try decoder.decode(LessonDTO.self, from: returnedBody)
        } catch {
            if areDatesValid(statusCode: response.statusCode) {
                throw DataSourceError.decodingError(
                    "Data of \(returnedBody) could not be decoded!"
                )
            } else {
                throw APIValidationError.invalidDates
            }
        }
        
        return createdBody
    }
    
    func update(_ body: LessonBodyDTO, id: UUID) async throws {
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

        var response: HTTPURLResponse? = nil
        do {
            (_, response) = try await client.request(request)
        } catch let error as NSError {
            throw error
        } catch {
            throw DataSourceError.updatingError("Data of \(body) could not be updated!")
        }
        
        guard let response = response, areDatesValid(statusCode: response.statusCode) else {
            throw APIValidationError.invalidDates
        }
    }
    
    func getOpenLessons() async throws -> [LessonDTO] {
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "open")
            .setMethod(.get)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL)open not found")
        }
        
        let fetchedData: Data
        do {
            (fetchedData, _) = try await client.request(request)
        } catch let error as NSError {
            throw error
        } catch {
            throw DataSourceError.fetchingError("Open lessons could not be fetched!")
        }
        
        let data: [LessonDTO]
        do {
            data = try decoder.decode([LessonDTO].self, from: fetchedData)
        } catch {
            throw DataSourceError.decodingError("Open lessons could not be decoded!")
        }
        
        return data
    }
    
    func getLessonsByTeacherId(_ id: UUID) async throws -> [LessonDTO] {
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "teacher/\(id)")
            .setMethod(.get)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL)teacher/\(id) not found")
        }
        
        let fetchedData: Data
        do {
            (fetchedData, _) = try await client.request(request)
        } catch let error as NSError {
            throw error
        } catch {
            throw DataSourceError.fetchingError(
                "Lessons for teacherId: \(id) could not be fetched!"
            )
        }
        
        let data: [LessonDTO]
        do {
            data = try decoder.decode([LessonDTO].self, from: fetchedData)
        } catch {
            throw DataSourceError.decodingError(
                "Lessons for teacherId: \(id) could not be decoded!"
            )
        }
        
        return data
    }
    
    func getLessonsByStudentId(_ id: UUID) async throws -> [LessonDTO] {
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "student/\(id)")
            .setMethod(.get)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL)student/\(id) not found")
        }
        
        let fetchedData: Data
        do {
            (fetchedData, _) = try await client.request(request)
        } catch let error as NSError {
            throw error
        } catch {
            throw DataSourceError.fetchingError(
                "Lessons for studentId: \(id) could not be fetched!"
            )
        }
        
        let data: [LessonDTO]
        do {
            data = try decoder.decode([LessonDTO].self, from: fetchedData)
        } catch {
            throw DataSourceError.decodingError(
                "Lessons for studentId: \(id) could not be decoded!"
            )
        }
        
        return data
    }
    
    func getLessonsByLessonTypeId(_ id: UUID) async throws -> [LessonDTO] {
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "lesson-type/\(id)")
            .setMethod(.get)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL)lesson-type/\(id) not found")
        }
        
        let fetchedData: Data
        do {
            (fetchedData, _) = try await client.request(request)
        } catch let error as NSError {
            throw error
        } catch {
            throw DataSourceError.fetchingError(
                "Lessons for lessonTypeId: \(id) could not be fetched!"
            )
        }
        
        let data: [LessonDTO]
        do {
            data = try decoder.decode([LessonDTO].self, from: fetchedData)
        } catch {
            throw DataSourceError.decodingError(
                "Lessons for lessonTypeId: \(id) could not be decoded!"
            )
        }
        
        return data
    }
    
    func takeLesson(_ body: LessonBodyDTO, id: UUID) async throws {
        let lessonBody: Data
        do {
            lessonBody = try encoder.encode(body)
        } catch {
            throw DataSourceError.encodingError("Lesson of \(body) could not be encoded!")
        }
        
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "take-lesson/\(id)")
            .setMethod(.put)
            .useJsonContentType()
            .setBody(lessonBody)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL)take-lesson/\(id) not found")
        }
        
        var response: HTTPURLResponse? = nil
        do {
            (_, response) = try await client.request(request)
        } catch let error as NSError {
            throw error
        } catch {
            if let response = response, areDatesValid(statusCode: response.statusCode) {
                throw DataSourceError.updatingError("Lesson of \(body) could not be updated!")
            } else {
                throw APIValidationError.invalidDates
            }
        }
    }

    func delete(_ id: UUID) async throws {
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "\(id)")
            .setMethod(.delete)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL)/\(id) not found")
        }

        var response: HTTPURLResponse? = nil
        do {
            (_, response) = try await client.request(request)
        } catch let error as NSError {
            throw error
        } catch {
            throw DataSourceError.deletingError("Lesson with ID \(id) could not be deleted!")
        }
        
        guard let response = response, areDatesValid(statusCode: response.statusCode) else {
            throw APIValidationError.invalidDates
        }
    }
}

private extension LessonDataSource {
    func areDatesValid(statusCode: Int) -> Bool {
        statusCode != 403 && statusCode != 409
    }
}
