//
//  MainIntentImp.swift
//  MainFeature
//
//  Created by phang on 11/21/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Combine
import SwiftUI

import Common
import Core
import Domain

@MainActor
final class MainIntentImp {
    //
    private weak var model: MainModelAction?
    //
    private let hapticManager: HapticManager
    private let scrollService: MainViewScrollService

    //
    init(
        model: MainModelAction,
        hapticManager: HapticManager = .shared,
        scrollService: MainViewScrollService
    ) {
        self.model = model
        self.hapticManager = hapticManager
        self.scrollService = scrollService
    }
}

extension MainIntentImp: MainIntent {
    func tabQuestionmarkButton() {
        //
    }
    
    func handleControlBoxGeoChange(
        control: JournalContentControl,
        newFrame: CGRect,
        controlIndex: Int
    ) {
        model?.controlBoxGeoChange(control: control,
                                   newFrame: newFrame,
                                   controlIndex: controlIndex)
    }
    
    func handleControlSelect(_ control: JournalContentControl) {
        model?.updateSelectedControl(control)
        model?.updateSelectedControlFrame(control.frame)
        hapticManager.triggerImpact(style: .medium)
        model?.updateSelectedControlScale(.selected)
    }
    
    func handleAutoScroll(
        location: CGPoint,
        proxy: ScrollViewProxy,
        safeArea: EdgeInsets,
        selectedControl: JournalContentControl,
        controls: [JournalContentControl],
        offset: CGSize
    ) {
        // BoxView의 현재 프레임 계산
        let currentFrame = CGRect(
            x: selectedControl.frame.origin.x + offset.width,
            y: selectedControl.frame.origin.y + offset.height,
            width: selectedControl.frame.width,
            height: selectedControl.frame.height
        )
        //
        let currentIndex = controls.firstIndex { $0.id == selectedControl.id } ?? 0
        //
        scrollService.startScrolling(at: location,
                                     currentFrame: currentFrame,
                                     safeArea: safeArea,
                                     controls: controls,
                                     currentIndex: currentIndex,
                                     proxy: proxy)
    }
    
    func handleDragEnded() {
        model?.controlDragEnd()
    }
    
    func checkAndSwapItems(location: CGPoint) {
        model?.checkAndSwapItems(location: location)
    }
    
    func updateDragOffset(_ offset: CGSize) {
        model?.updateDragOffset(offset)
    }
    
    func clearSelectedControl() {
        model?.updateSelectedControl(nil)
    }
}
