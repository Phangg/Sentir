//
//  SchemePickerView+Build.swift
//  SettingFeature
//
//  Created by phang on 12/20/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

import Core
import Common

extension SchemePickerView {
    //
    public static func build(
        previews: [SchemePreview]
    ) -> some View {
        let model = SchemeModelImp(previews: previews)
        let intent = SchemeIntentImp(
            model: model
        )
        let container = MVIContainer(
            intent: intent as SchemeIntent,
            model: model as SchemeModelState,
            modelChangePublisher: model.objectWillChange
        )
        let view = SchemePickerView(container: container)
        return view
    }
}
