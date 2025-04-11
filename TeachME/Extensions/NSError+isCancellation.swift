//
//  NSError+isCancellation.swift
//  TeachME
//
//  Created by TumbaDev on 8.04.25.
//

import Foundation

extension NSError {
    var isCancellation: Bool {
        domain == NSURLErrorDomain && code == NSURLErrorCancelled
    }
}
