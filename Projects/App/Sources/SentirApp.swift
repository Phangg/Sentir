//
//  SentirApp.swift
//  App
//
//  Created by phang on 8/28/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import Common
import MainTabFeature
import SwiftUI

@main
struct SentirApp: App {
    @ObservedObject private var tabBarState = TabBarState.shared

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(tabBarState)
        }
    }
}
