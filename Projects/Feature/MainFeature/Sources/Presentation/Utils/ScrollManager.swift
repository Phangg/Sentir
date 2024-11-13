//
//  ScrollManager.swift
//  MainFeature
//
//  Created by phang on 11/13/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

@MainActor
final class ScrollManager: ObservableObject {
    @Published var currentIndex: Int = 0
    @Published var scrollDirection: ScrollDirection = .none
    @Published var controls: [JournalContentControl] = []
    private let scrollInterval: TimeInterval = 0.016
    static let scrollSpeed: CGFloat = 15

    @MainActor
    enum ScrollDirection {
        case up
        case down
        case none
        
        var speed: CGFloat {
            switch self {
            case .up:
                return -ScrollManager.scrollSpeed
            case .down:
                return ScrollManager.scrollSpeed
            case .none:
                return 0
            }
        }
    }
    
    func updateScrollOffset(isScrollingUp: Bool) {
        scrollDirection = isScrollingUp ? .up : .down
    }
    
    func scroll(using proxy: ScrollViewProxy) {
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
