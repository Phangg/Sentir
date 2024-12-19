//
//  PasswordSheetView+Build.swift
//  SettingFeature
//
//  Created by phang on 12/19/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

import Core

extension PasswordSheetView {
    //
    public static func build(
        finishSetPasswordCompletion: @escaping () -> Void
    ) -> some View {
        let model = PasswordModelImp()
        let intent = PasswordIntentImp(
            model: model,
            finishSetPasswordCompletion: finishSetPasswordCompletion
        )
        let container = MVIContainer(
            intent: intent as PasswordIntent,
            model: model as PasswordModelState,
            modelChangePublisher: model.objectWillChange
        )
        let view = PasswordSheetView(container: container)
        return view
    }
}
