//
//  LessonRouter.swift
//  TeachME
//
//  Created by TumbaDev on 3.02.25.
//

import Foundation
import SwiftUI

protocol Router {
    func start() -> any View
}

class IdentifiableRouter: Identifiable {
    let router: Router

    init(router: Router) {
        self.router = router
    }

    func start() -> some View {
        AnyView(router.start())
    }
}
