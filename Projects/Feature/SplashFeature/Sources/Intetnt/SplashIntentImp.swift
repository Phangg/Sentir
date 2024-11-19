//
//  SplashIntentImp.swift
//  SplashFeature
//
//  Created by phang on 11/16/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

class SplashIntentImp {
    // Model
    private weak var model: SplashModelAction?
    // Dependencies

    // Business Data

    
    //
    init(
        model: SplashModelAction
    ) {
        self.model = model
    }
}

extension SplashIntentImp: SplashIntent {
    //
    func viewOnAppear() {
        model?.displayLoading()
        
        // TODO: - 실제 fetch 과정으로 수정 필요
        print("데이터 받아오는 중...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.model?.finishSplashFetch()
        }
    }
}
