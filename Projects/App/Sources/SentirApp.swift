//
//  SentirApp.swift
//  App
//
//  Created by phang on 8/28/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

import Common
import AppFlowFeature

@main
struct SentirApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            AppFlowView()
        }
    }
}
