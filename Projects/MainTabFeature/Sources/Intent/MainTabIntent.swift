//
//  MainTabIntent.swift
//  MainTabFeature
//
//  Created by phang on 11/21/24.
//  Copyright © 2024 Phang. All rights reserved.
//

@MainActor
protocol MainTabIntent: AnyObject {
    //
    func changeTab(to tab: TabType)
    func removeDefaultTabBar()
}
