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
    
    func create(_ body: LessonCreateBodyDTO) async throws -> LessonDTO {
        let jsonBody: Data
        do {
           jsonBody = try encoder.encode(body)
        } catch {
           throw DataSourceError.encodingError("CreateBody of \(body) could not be encoded!")
        }
        
        guard let request = try URLRequestBuilder(baseURL: baseURL)
            .setMethod(.post)
            .setBody(jsonBody)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL) not found")
        }

        let returnedBody: Data
        do {
            (returnedBody, _) = try await client.request(request)
        } catch {
           throw DataSourceError.postingError("CreateBody of \(body) could not be created!")
        }
        
        let createdBody: LessonDTO
        do {
            createdBody = try decoder.decode(LessonDTO.self, from: returnedBody)
        } catch {
            throw DataSourceError.decodingError("Data of \(returnedBody) could not be decoded!")
        }
        
        return createdBody
    }
    
    func getOpenLessons() async throws -> [LessonDTO] {
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "open")
            .setMethod(.get)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL)/open not found")
        }
        
        let fetchedData: Data
        do {
            (fetchedData, _) = try await client.request(request)
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
            throw DataSourceError.invalidURL("\(baseURL)/teacher/\(id) not found")
        }
        
        let fetchedData: Data
        do {
            (fetchedData, _) = try await client.request(request)
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
            throw DataSourceError.invalidURL("\(baseURL)/student/\(id) not found")
        }
        
        let fetchedData: Data
        do {
            (fetchedData, _) = try await client.request(request)
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
            throw DataSourceError.invalidURL("\(baseURL)/lesson-type/\(id) not found")
        }
        
        let fetchedData: Data
        do {
            (fetchedData, _) = try await client.request(request)
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
    
    func takeLesson(lesson: LessonDTO) async throws {
        let lessonData: Data
        do {
            lessonData = try encoder.encode(lesson)
        } catch {
            throw DataSourceError.encodingError("Lesson of \(lesson) could not be encoded!")
        }
        
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "\(lesson.id)")
            .setMethod(.put)
            .setBody(lessonData)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL)/take-lesson/\(lesson.id) not found")
        }

        do {
            let _ = try await client.request(request)
        } catch {
            throw DataSourceError.updatingError("Lesson of \(lesson) could not be updated!")
        }
    }
}
