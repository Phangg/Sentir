//
//  AlarmSheetView+Build.swift
//  SettingFeature
//
//  Created by phang on 12/20/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

import Core

extension AlarmSheetView {
    //
    public static func build(
        alarmTime: AlarmTime,
        updateAlarmTimeCompletion: @escaping (AlarmTime) -> Void,
        finishSetAlarmCompletion: @escaping () -> Void
    ) -> some View {
        let model = AlarmModelImp(alarmTime: alarmTime)
        let intent = AlarmIntentImp(
            model: model,
            setAlarmTimeCompletion: updateAlarmTimeCompletion,
            finishSetAlarmCompletion: finishSetAlarmCompletion
        )
        let container = MVIContainer(
            intent: intent as AlarmIntent,
            model: model as AlarmModelState,
            modelChangePublisher: model.objectWillChange
        )
        let view = AlarmSheetView(container: container)
        return view
    }
}
