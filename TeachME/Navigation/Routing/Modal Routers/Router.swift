//
//  LessonRouter.swift
//  TeachME
//
//  Created by TumbaDev on 3.02.25.
//

import Foundation
import SwiftUI

protocol Router: ObservableObject {
    associatedtype V: View
    
    func push(_ destination: Destination)
    func popToRoot()
    
    var path: [Destination] { get set }
    var initialDestination: V { get }
}

final class EmptyRouter: Router {
    var initialDestination: EmptyView = EmptyView()
    
    var path = [Destination]()
    
    func push(_ destination: Destination) {
        path.append(destination)
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
