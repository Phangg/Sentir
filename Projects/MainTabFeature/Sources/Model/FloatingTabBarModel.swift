//
//  FloatingTabBarModel.swift
//  MainTabFeature
//
//  Created by phang on 11/21/24.
//  Copyright © 2024 Phang. All rights reserved.
//

// MARK: - State
protocol FloatingTabBarModelState: AnyObject {
    var currentTab: TabType { get }
}
