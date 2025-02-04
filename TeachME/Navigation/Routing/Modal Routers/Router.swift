//
//  LessonRouter.swift
//  TeachME
//
//  Created by TumbaDev on 3.02.25.
//

import Foundation
import SwiftUI

protocol Router {
    func onLessonTapped(lesson: LessonItem)
    func popToRoot()
}
