//
//  MainTabModelImp.swift
//  MainTabFeature
//
//  Created by phang on 11/21/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

import Common

public final class MainTabModelImp: ObservableObject, MainTabModelState {
    //
    @Published private(set) var currentTab: TabType
    @Published private(set) var isDefaultTabBarHidden: Bool
    //
    private let tabBarStateManager: TabBarStateManageable
    var tabBarState: TabBarStateManageable { tabBarStateManager }
    
    //
    init(
        currentTab: TabType = .main,
        isDefaultTabBarHidden: Bool = false,
        tabBarStateManager: TabBarStateManageable = TabBarState.shared
    ) {
        self.currentTab = currentTab
        self.isDefaultTabBarHidden = isDefaultTabBarHidden
        self.tabBarStateManager = tabBarStateManager
    }
}

extension MainTabModelImp: MainTabModelAction {
    func removeDefaultTabBar() {
        isDefaultTabBarHidden = true
    }
    
    func updateTab(_ tab: TabType) {
        currentTab = tab
    }
}
