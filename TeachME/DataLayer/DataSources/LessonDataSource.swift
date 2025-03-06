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
    let url: String
    let encoder: JSONEncoder
    let decoder: JSONDecoder
    
    init(client: HTTPClient, url: String, encoder: JSONEncoder, decoder: JSONDecoder) {
        self.client = client
        self.url = url
        self.encoder = encoder
        self.decoder = decoder
    }
    
    func getOpenLessons() async throws -> [LessonDTO] {
        guard let request = URLRequestBuilder(baseURL: url, path: "open")
            .setMethod(.get)
            .build()
        else {
            throw DataSourceError.invalidURL("\(url)/open not found")
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
        guard let request = URLRequestBuilder(baseURL: url, path: "teacher/\(id)")
            .setMethod(.get)
            .build()
        else {
            throw DataSourceError.invalidURL("\(url)/teacher/\(id) not found")
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
        guard let request = URLRequestBuilder(baseURL: url, path: "student/\(id)")
            .setMethod(.get)
            .build()
        else {
            throw DataSourceError.invalidURL("\(url)/student/\(id) not found")
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
        guard let request = URLRequestBuilder(baseURL: url, path: "lesson-type/\(id)")
            .setMethod(.get)
            .build()
        else {
            throw DataSourceError.invalidURL("\(url)/lesson-type/\(id) not found")
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
        let jsonData: Data
        do {
            jsonData = try encoder.encode(lesson)
        } catch {
            throw DataSourceError.encodingError("Lesson of \(lesson) could not be encoded!")
        }
        
        guard let request = URLRequestBuilder(baseURL: url, path: "\(lesson.id)")
            .setMethod(.put)
            .setHeaders(["application/json": "Content-Type"])
            .setBody(jsonData)
            .build()
        else {
            throw DataSourceError.invalidURL("\(url)/take-lesson/\(lesson.id) not found")
        }

        do {
            let _ = try await client.request(request)
        } catch {
            throw DataSourceError.updatingError("Lesson of \(lesson) could not be updated!")
        }
    }
}
