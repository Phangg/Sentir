//
//  SentirMainView+Build.swift
//  MainFeature
//
//  Created by phang on 12/20/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

import Core

extension SentirMainView {
    //
    public static func build() -> some View {
        let scrollService = MainViewScrollServiceImp()
        let model = MainModelImp()
        let intent = MainIntentImp(
            model: model,
            scrollService: scrollService
        )
        let container = MVIContainer(
            intent: intent as MainIntent,
            model: model as MainModelState,
            modelChangePublisher: model.objectWillChange
        )
        let view = SentirMainView(container: container)
        return view
    }
}
