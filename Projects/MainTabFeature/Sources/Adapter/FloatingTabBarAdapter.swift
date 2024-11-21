//
//  FloatingTabBarAdapter.swift
//  MainTabFeature
//
//  Created by phang on 11/21/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

final class FloatingTabBarAdapter: ObservableObject {
    @Published private(set) var state: MainTabModelState
    let intent: MainTabIntent

    init(
        intent: MainTabIntent,
        state: MainTabModelState
    ) {
        self.intent = intent
        self.state = state
    }
}

// Intent
extension FloatingTabBarAdapter: FloatingTabBarIntent {
    func changeTab(to tab: TabType) {
        intent.changeTab(to: tab)
    }
}

// State
extension FloatingTabBarAdapter: FloatingTabBarModelState {
    var currentTab: TabType {
        state.currentTab
    }
}
