//
//  DateFormatterHelper.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/07.
//

import Foundation

final class DateFormatterHelper {
    
    private init() {}
    
    static let Formatter = DateFormatterHelper()
    
    let dateFormatter = DateFormatter()
    
    func formatDate() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
    }
    
    var dateStr: String {
        get {
            formatDate()
            return dateFormatter.string(from: Date())
        }
    }
    
    func selectDay(day: Date) -> String {
        formatDate()
        return dateFormatter.string(from: day)
    }
    
}
