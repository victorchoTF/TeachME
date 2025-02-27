//
//  DateFormatter+toDate.swift
//  TeachME
//
//  Created by TumbaDev on 20.02.25.
//

import Foundation

extension DateFormatter {
    func toDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        let formats = [
            "hh:mma dd.MM.yyyy",
            "HH:mm dd.MM.yyyy"
        ]
        
        for format in formats {
            dateFormatter.dateFormat = format
            if let date = dateFormatter.date(from: dateString) {
                return date
            }
        }
        
        return nil
    }
}
