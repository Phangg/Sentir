//
//  AppFlowIntentImp.swift
//  AppFlowFeature
//
//  Created by phang on 11/15/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Common

protocol AppFlowIntent: AnyObject {
    //
    var appScheme: AppScheme { get }
    //
    func updateScheme(_ scheme: AppScheme)
    func finishSplash()
    func completeOnboarding()
}
