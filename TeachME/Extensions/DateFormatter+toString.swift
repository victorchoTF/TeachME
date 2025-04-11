//
//  DateFormatter+toString.swift
//  TeachME
//
//  Created by TumbaDev on 20.02.25.
//

import Foundation

extension DateFormatter {
    func toString(_ date: Date, useMilitaryTime: Bool = true) -> String {
        let formatter = DateFormatter()
        if useMilitaryTime {
            formatter.dateFormat = "HH:mm dd.MM.yyyy"
        } else {
            formatter.dateFormat = "h:mma dd.MM.yyyy"
            formatter.amSymbol = "AM"
            formatter.pmSymbol = "PM"
        }
        return formatter.string(from: date)
    }
}
