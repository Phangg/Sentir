//
//  SplashModelImp.swift
//  SplashFeature
//
//  Created by phang on 11/16/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

public final class SplashModelImp: ObservableObject, SplashModelState {
    //
    @Published private(set) var isLoading: Bool

    //
    init(
        isLoading: Bool = true
    ) {
        self.isLoading = isLoading
    }
}

extension SplashModelImp: SplashModelAction {
    func finishSplashFetch() {
        print("Splash - fetch 완료")
        isLoading = false
    }
    
    func displayLoading() {
        isLoading = true
    }
    
    func displayError(_ error: any Error) {
        isLoading = false
        fatalError("Splash View Error - \(error)")
    }
}
