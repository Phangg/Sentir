//
//  AlarmTime.swift
//  SettingFeature
//
//  Created by phang on 9/24/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

public struct AlarmTime {
    public var timeOfDay: TimeOfDay
    public var hours: Int
    public var minutes: Int
    
    public init(
        timeOfDay: TimeOfDay,
        hours: Int,
        minutes: Int
    ) {
        self.timeOfDay = timeOfDay
        self.hours = hours
        self.minutes = minutes
    }
}
