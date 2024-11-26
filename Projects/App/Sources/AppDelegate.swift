//
//  AppDelegate.swift
//  App
//
//  Created by phang on 11/15/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    //
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        //
        registerDependencies()
        //
        return true
    }
}
