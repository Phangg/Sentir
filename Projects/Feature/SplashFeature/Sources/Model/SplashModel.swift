//
//  SplashModel.swift
//  SplashFeature
//
//  Created by phang on 11/14/24.
//  Copyright © 2024 Phang. All rights reserved.
//

// MARK: - State
protocol SplashModelState {
    var isLoading: Bool { get }
}

// MARK: - Action
protocol SplashModelAction: AnyObject {
    func displayLoading()
    func displayError(_ error: Error)
    func finishSplashFetch()
}
