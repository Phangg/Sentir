//
//  SplashIntent.swift
//  SplashFeature
//
//  Created by phang on 11/14/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Combine

@MainActor
protocol SplashIntent: AnyObject {
    //
    var finishSplashPublisher: AnyPublisher<Void, Never> { get }
    var finishSplashCompletion: () -> Void { get }
    //
    func viewOnAppear()
}
