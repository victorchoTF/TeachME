//
//  UserDetailDTO.swift
//  TeachME
//
//  Created by TumbaDev on 2.03.25.
//

import Foundation

final class UserDetailTypeDataSource: DataSource {
    typealias DataType = UserDetailDTO
    
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
}
