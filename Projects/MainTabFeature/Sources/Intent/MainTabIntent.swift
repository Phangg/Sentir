//
//  MainTabIntent.swift
//  MainTabFeature
//
//  Created by phang on 11/21/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Common

@MainActor
protocol MainTabIntent: AnyObject {
    //
    var tabBarState: TabBarStateManageable { get }
    //
    func changeTab(to tab: TabType)
    func removeDefaultTabBar()
}
