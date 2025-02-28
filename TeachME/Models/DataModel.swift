//
//  DataModel.swift
//  TeachME
//
//  Created by TumbaDev on 28.02.25.
//

import Foundation

protocol DataModel: Codable, Identifiable {
    var id: UUID { get }
}
