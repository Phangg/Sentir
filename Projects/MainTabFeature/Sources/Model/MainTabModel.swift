//
//  MainTabModel.swift
//  MainTabFeature
//
//  Created by phang on 11/21/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Common

// MARK: - State
protocol MainTabModelState: AnyObject {
    var currentTab: TabType { get }
    var isDefaultTabBarHidden: Bool { get }
}

// MARK: - Action
protocol MainTabModelAction: AnyObject {
    func removeDefaultTabBar()
    func updateTab(_ tab: TabType)
}
