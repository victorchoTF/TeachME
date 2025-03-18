//
//  Role.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import Foundation

// TODO: Make into a struct and fetch the data from the API
enum Role: String, CaseIterable {
    case Student = "aeaa842a-d829-4aa6-91f8-75efee072c7e"
    case Teacher = "748accfc-58d9-4d2f-aaa7-703901ee4433"
    
    var caseName: String {
        return String(describing: self)
    }
}
