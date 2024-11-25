//
//  MainIntent.swift
//  MainFeature
//
//  Created by phang on 11/21/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

@MainActor
protocol MainIntent {
    //
    func viewOnAppear()
    func schemeChange()
    func tabQuestionmarkButton()
    //
    func handleControlBoxGeoChange(
        control: JournalContentControl,
        newFrame: CGRect,
        controlIndex: Int
    )
    func handleControlSelect(_ control: JournalContentControl)
    func handleAutoScroll(
        location: CGPoint,
        proxy: ScrollViewProxy,
        safeArea: EdgeInsets,
        selectedControl: JournalContentControl,
        controls: [JournalContentControl],
        offset: CGSize
    )
    func handleDragEnded()
    //
    func checkAndSwapItems(location: CGPoint)
    func updateDragOffset(_ offset: CGSize)
    func clearSelectedControl()
}
