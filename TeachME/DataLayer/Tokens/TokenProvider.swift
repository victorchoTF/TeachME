//
//  TokenProvider.swift
//  TeachME
//
//  Created by TumbaDev on 13.03.25.
//

import Foundation

protocol TokenProvider {    
    func token() throws -> TokenResponse
}
