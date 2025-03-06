//
//  DataSourceError.swift
//  TeachME
//
//  Created by TumbaDev on 28.02.25.
//

import Foundation

enum DataSourceError: Error {
    case encodingError(String)
    case decodingError(String)
    case postingError(String)
    case fetchingError(String)
    case updatingError(String)
    case deletingError(String)
    case invalidURL(String)
}
