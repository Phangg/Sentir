//
//  JournalView+Build.swift
//  JournalFeature
//
//  Created by phang on 12/20/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

import Core

extension JournalView {
    //
    public static func build() -> some View {
        let model = JournalModelImp()
        let intent = JournalIntentImp(model: model)
        let container = MVIContainer(
            intent: intent as JournalIntent,
            model: model as JournalModelState,
            modelChangePublisher: model.objectWillChange
        )
        let view = JournalView(container: container)
        return view
    }
}
