//
//  SentirApp.swift
//  App
//
//  Created by phang on 8/28/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

import AppFlowFeature

@main
struct SentirApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            AppFlowView()
        }
    }
}
