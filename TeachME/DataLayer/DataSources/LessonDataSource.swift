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
        var request = URLRequest(url: url.appendingPathComponent("open"))
        
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
        let subURL = url.appendingPathComponent("teacher")
        
        var request = URLRequest(url: subURL.appendingPathComponent("\(id)"))
        
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
        let subURL = url.appendingPathComponent("student")
        
        var request = URLRequest(url: subURL.appendingPathComponent("\(id)"))
        
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
        let subURL = url.appendingPathComponent("lesson-type")
        
        var request = URLRequest(url: subURL.appendingPathComponent("\(id)"))
        
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
        let subURL = url.appendingPathComponent("take-lesson")
        
        var request = URLRequest(url: subURL.appendingPathComponent("\(lesson.id)"))
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try encoder.encode(lesson)
            request.httpBody = jsonData
        } catch {
            throw DataSourceError.encodingError("Lesson of \(lesson) could not be encoded!")
        }

        do {
            let _ = try await client.request(request)
        } catch {
            throw DataSourceError.updatingError("Lesson of \(lesson) could not be updated!")
        }
    }
}
