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
    private static let dateInfoFormatStyle = "yyyy년 MMMM dd일 EEEE"
//    private static let timeInfoFormatStyle = "a h시 m분 s초"
    private static let timeInfoFormatStyle = "a h시 m분"

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
}
