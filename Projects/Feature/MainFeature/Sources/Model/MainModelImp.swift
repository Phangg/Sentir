//
//  MainModelImp.swift
//  MainFeature
//
//  Created by phang on 11/21/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Combine
import SwiftUI

final class MainModelImp: ObservableObject, MainModelState {
    //
    @Published private(set) var controls: [JournalContentControl]
    @Published private(set) var selectedControl: JournalContentControl?
    @Published private(set) var selectedControlFrame: CGRect
    @Published private(set) var selectedControlScale: CGFloat
    @Published private(set) var dragOffset: CGSize
    
    //
    init(
        // TODO: - 개인 데이터로 저장 되어야 하는 controls 배열 (순서)
        controls: [JournalContentControl] = JournalContentControl.controls,
        selectedControl: JournalContentControl? = nil,
        selectedControlFrame: CGRect = .zero,
        selectedControlScale: CGFloat = 1.0,
        dragOffset: CGSize = .zero
    ) {
        self.controls = controls
        self.selectedControl = selectedControl
        self.selectedControlFrame = selectedControlFrame
        self.selectedControlScale = selectedControlScale
        self.dragOffset = dragOffset
    }
}

extension MainModelImp: MainModelAction {
    func updateScheme() {
        //
    }
    
    func controlBoxGeoChange(
        control: JournalContentControl,
        newFrame: CGRect,
        controlIndex: Int
    ) {
        if selectedControl == control {
            selectedControlFrame = newFrame
        }
        controls[controlIndex].frame = newFrame
    }
    
    func updateSelectedControl(_ control: JournalContentControl?) {
        selectedControl = control
    }
    
    func updateSelectedControlFrame(_ frame: CGRect) {
        selectedControlFrame = frame
    }
    
    func updateSelectedControlScale(_ scale: JournalContentControlScaleType) {
        selectedControlScale = scale.value
    }
    
    func updateDragOffset(_ offset: CGSize) {
        dragOffset = offset
    }
    
    func checkAndSwapItems(location: CGPoint) {
        if let currentIndex = controls.firstIndex(where: { $0.id == selectedControl?.id }),
           let swapIndex = controls.firstIndex(where: { $0.frame.contains(location) }),
           currentIndex != swapIndex {
            controls.swapAt(currentIndex, swapIndex)
        }
    }
    
    func controlDragEnd() {
        selectedControl?.frame = selectedControlFrame
        selectedControlScale = JournalContentControlScaleType.default.value
        dragOffset = .zero
    }
}
