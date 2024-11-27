//
//  MainTabIntentImp.swift
//  MainTabFeature
//
//  Created by phang on 11/21/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

import Common
import Core

@MainActor
final class MainTabIntentImp {
    //
    private let model: MainTabModelAction?
    //
    @Injected(TabBarStateManageable.self)
    var tabBarState: TabBarStateManageable
    
    init(
        model: MainTabModelAction
    ) {
        self.model = model
    }
}

// MARK: - Intent
extension MainTabIntentImp: MainTabIntent {
    func changeTab(to tab: TabType) {
        model?.updateTab(tab)
    }
    
    func removeDefaultTabBar() {
        model?.removeDefaultTabBar()
    }
}
