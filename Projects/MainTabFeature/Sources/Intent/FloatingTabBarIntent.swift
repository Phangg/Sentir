//
//  FloatingTabBarIntent.swift
//  MainTabFeature
//
//  Created by phang on 11/21/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

@MainActor
protocol FloatingTabBarIntent {
    func changeTab(to tab: TabType)
}
