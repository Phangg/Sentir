//
//  MainModel.swift
//  MainFeature
//
//  Created by phang on 11/21/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

// MARK: - State
protocol MainModelState: AnyObject {
    var controls: [JournalContentControl] { get }
    var selectedControl: JournalContentControl? { get }
    var selectedControlFrame: CGRect { get }
    var selectedControlScale: CGFloat { get }
    var dragOffset: CGSize { get }
}

// MARK: - Action
protocol MainModelAction: AnyObject {
    //
    func updateScheme()
    //
    func controlBoxGeoChange(
        control: JournalContentControl,
        newFrame: CGRect,
        controlIndex: Int
    )
    func updateSelectedControl(_ control: JournalContentControl?)
    func updateSelectedControlFrame(_ frame: CGRect)
    func updateSelectedControlScale(_ scale: JournalContentControlScaleType)
    func updateDragOffset(_ offset: CGSize)
    func checkAndSwapItems(location: CGPoint)
    func controlDragEnd()
}
