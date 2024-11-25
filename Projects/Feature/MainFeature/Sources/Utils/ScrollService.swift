//
//  ScrollService.swift
//  MainFeature
//
//  Created by phang on 11/25/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

import Common

// MARK: - Protocol
@MainActor
protocol MainViewScrollService {
    //
    var isScrolling: Bool { get }
    //
    func startScrolling(at location: CGPoint,
                       currentFrame: CGRect,
                       safeArea: EdgeInsets,
                       controls: [JournalContentControl],
                       currentIndex: Int,
                       proxy: ScrollViewProxy)
    func stopScrolling()
}

// MARK: - Imp
@MainActor
final class MainViewScrollServiceImp: MainViewScrollService, ObservableObject {
    //
    @Published private var scrollDirection: ScrollDirection = .none
    private(set) var isScrolling: Bool = false
    private var controls: [JournalContentControl] = []
    private var currentIndex: Int = 0
    //
    private let scrollInterval: TimeInterval = 0.016
    private let scrollThreshold: CGFloat = 100
    
    //
    @MainActor
    private enum ScrollDirection {
        case up
        case down
        case none
        
        var speed: CGFloat {
            switch self {
            case .up: return -15
            case .down: return 15
            case .none: return 0
            }
        }
    }
    
    //
    func startScrolling(
        at location: CGPoint,
        currentFrame: CGRect,
        safeArea: EdgeInsets,
        controls: [JournalContentControl],
        currentIndex: Int,
        proxy: ScrollViewProxy
    ) {
        self.controls = controls
        self.currentIndex = currentIndex
        // 상단, 하단 스크롤 영역 체크
        let topThreshold = scrollThreshold + safeArea.top
        let bottomThreshold = UIScreen.main.bounds.height - scrollThreshold
        // BoxView의 top과 bottom 위치로 체크
        let isInTopRegion = currentFrame.minY <= topThreshold
        let isInBottomRegion = currentFrame.maxY >= bottomThreshold
        //
        stopScrolling()
        //
        guard isInTopRegion || isInBottomRegion else { return }
        
        isScrolling = true
        scrollDirection = isInTopRegion ? .up : .down
        
        scroll(using: proxy)
    }
    
    func stopScrolling() {
        isScrolling = false
        scrollDirection = .none
    }
    
    //
    private func scroll(using proxy: ScrollViewProxy) {
        guard isScrolling else { return }
        
        switch scrollDirection {
        case .up:
            let targetIndex = max(0, currentIndex - 1)
            withAnimation(.linear(duration: scrollInterval)) {
                proxy.scrollTo(controls[targetIndex].type, anchor: .top)
            }
        case .down:
            let targetIndex = min(controls.count - 1, currentIndex + 1)
            withAnimation(.linear(duration: scrollInterval)) {
                proxy.scrollTo(controls[targetIndex].type, anchor: .bottom)
            }
        case .none:
            break
        }
    }
}
