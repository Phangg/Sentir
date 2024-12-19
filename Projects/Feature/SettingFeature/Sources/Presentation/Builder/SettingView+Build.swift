//
//  SettingView+Build.swift
//  SettingFeature
//
//  Created by phang on 12/19/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

import Core

extension SettingView {
    //
    public static func build() -> some View {
        let model = SettingModelImp()
        let intent = SettingIntentImp(
            model: model
        )
        let container = MVIContainer(
            intent: intent as SettingIntent,
            model: model as SettingModelState,
            modelChangePublisher: model.objectWillChange
        )
        let view = SettingView(container: container)
        return view
    }
}
