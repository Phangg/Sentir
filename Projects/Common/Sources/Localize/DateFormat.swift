//
//  DateFormat.swift
//  Common
//
//  Created by phang on 9/10/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import Foundation

public struct DateFormat {
    //
    private static let calendarDayFormatStyle = "MMMM yyyy dd"
    private static let dateInfoFormatStyle = "yyyy년 MMMM dd일 EEEE"
    private static let timeInfoFormatStyle = "a h시 m분"
    //
    public static let calendarHeaderDateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "YYYY.MM"
      return formatter
    }()

    //
    public init() { }

    //
    public static func dateToDateInfoString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = dateInfoFormatStyle
        return dateFormatter.string(from: date)
    }
    
    //
    public static func dateToTimeInfoString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = timeInfoFormatStyle
        return dateFormatter.string(from: date)
    }
    
    //
    public static func calendarDayString(_ date: Date) -> String {
        //
        let calendarDayFormatter = DateFormatter()
        calendarDayFormatter.dateFormat = calendarDayFormatStyle
        return calendarDayFormatter.string(from: date)
    }
}
