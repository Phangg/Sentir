//
//  MainTabModel.swift
//  MainTabFeature
//
//  Created by phang on 11/21/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Common

// MARK: - State
protocol MainTabModelState {
    var currentTab: TabType { get }
    var isDefaultTabBarHidden: Bool { get }
    var tabBarState: TabBarStateManageable { get }
}

// MARK: - Action
protocol MainTabModelAction: AnyObject {
    func removeDefaultTabBar()
    func updateTab(_ tab: TabType)
}
