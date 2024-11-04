//
//  HapticManager.swift
//  Common
//
//  Created by phang on 10/24/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

// MARK: - 햅틱 반응
public final class HapticManager {
    
    public static let shared = HapticManager()
    
    private init() { }
    
    public func triggerImpact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
    
    public func triggerNotification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
}
