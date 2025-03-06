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
    let url: String
    let encoder: JSONEncoder
    let decoder: JSONDecoder
    
    init(client: HTTPClient, url: String, encoder: JSONEncoder, decoder: JSONDecoder) {
        self.client = client
        self.url = url
        self.encoder = encoder
        self.decoder = decoder
    }
}
