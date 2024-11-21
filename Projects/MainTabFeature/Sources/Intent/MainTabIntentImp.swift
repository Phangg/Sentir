//
//  MainTabIntentImp.swift
//  MainTabFeature
//
//  Created by phang on 11/21/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

@MainActor
final class MainTabIntentImp {
    //
    private let model: MainTabModelAction?
    
    init(
        model: MainTabModelAction
    ) {
        self.model = model
    }
}

extension MainTabIntentImp: MainTabIntent {
    func changeTab(to tab: TabType) {
        model?.updateTab(tab)
    }
    
    func removeDefaultTabBar() {
        model?.removeDefaultTabBar()
    }
}
