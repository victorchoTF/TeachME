//
//  DateFormatter+toString.swift
//  TeachME
//
//  Created by TumbaDev on 20.02.25.
//

import Foundation

extension DateFormatter {
    func toString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma dd.MM.yyyy"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: date)
    }
}
