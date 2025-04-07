//
//  LessonRouter.swift
//  TeachME
//
//  Created by TumbaDev on 3.02.25.
//

import SwiftUI

protocol Router: ObservableObject {
    associatedtype V: View
    
    func push(_ destination: Destination)
    func popToRoot()
    
    var path: [Destination] { get set }
    var initialDestination: V { get }
}
