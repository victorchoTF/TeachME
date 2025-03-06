//
//  DataTransferObject.swift
//  TeachME
//
//  Created by TumbaDev on 28.02.25.
//

import Foundation

protocol DataTransferObject: Codable, Identifiable {
    var id: UUID { get }
}
