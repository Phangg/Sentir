//
//  MainContentView.swift
//  MainFeature
//
//  Created by phang on 9/28/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem
import FeatureDependency

struct MainContentView: View {
    @State private var controls: [JournalContentControl] = JournalContentControl.controls
    @State private var selectedControl: JournalContentControl?
    @State private var selectedControlFrame: CGRect = .zero
    @State private var selectedControlScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    //
    @StateObject private var scrollManager = ScrollManager()
    @State private var scrollTimer: Timer?
    private let scrollInterval: TimeInterval = 0.016
    //
    @Binding var showDescription: Bool
    //
    var safeArea: EdgeInsets
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                //
                LazyVStack(spacing: 20) {
                    ForEach(Array(controls.enumerated()), id: \.element.id) { index, control in
                        //
                        NavigationLink(value: control) {
                            //
                            ControlBoxView(control: control)
                                .padding(.top, index == 0 ? ViewValues.defaultPadding : 0)
                                .padding(.bottom, index == controls.count - 1 ? ViewValues.defaultPadding : 0)
                                .opacity(selectedControl?.id == control.id ? 0 : 1)
                                .onGeometryChange(for: CGRect.self) {
                                    $0.frame(in: .global)
                                } action: { newValue in
                                    if selectedControl?.id == control.id {
                                        selectedControlFrame = newValue
                                    }
                                    $controls[index].wrappedValue.frame = newValue
                                }
                                .gesture(customCombinedGesture(control, proxy: proxy))
                                .id(control.type)
                        }
                        .tint(DesignSystemAsset.black)
                    }
                }
                .padding(.horizontal, ViewValues.defaultPadding)
            }
            .overlay(DraggedControlOverlay)
            .navigationDestination(for: JournalContentControl.self) { control in
                WriteJournalView(viewState: .create,
                                 journalType: control.type)
            }
        }
    }
    
    @ViewBuilder
    private var DraggedControlOverlay: some View {
        if let selectedControl = selectedControl {
            ControlBoxView(control: selectedControl)
                .frame(width: selectedControl.frame.width,
                       height: selectedControl.frame.height)
                .scaleEffect(selectedControlScale)
                .position(x: selectedControl.frame.midX,
                          y: selectedControl.frame.midY)
                .offset(offset)
                .ignoresSafeArea()
                .transition(.identity)
        }
    }
    
    private func customCombinedGesture(
        _ control: JournalContentControl,
        proxy: ScrollViewProxy
    ) -> some Gesture {
        LongPressGesture(minimumDuration: 0.25)
            .sequenced(before: DragGesture(minimumDistance: 0, coordinateSpace: .global))
            .onChanged { value in
                switch value {
                case .second(let status, let dragValue):
                    if status {
                        if selectedControl == nil {
                            selectedControl = control
                            selectedControlFrame = control.frame
                            HapticManager.shared.triggerImpact(style: .medium)
                            withAnimation(.smooth(duration: 0.25, extraBounce: 0)) {
                                selectedControlScale = 1.05
                            }
                        }
                        if let dragValue = dragValue {
                            offset = dragValue.translation
                            let location = dragValue.location
                            checkAndScroll(location: location, proxy: proxy)
                            checkAndSwapItems(location)
                        }
                    }
                default:
                    break
                }
            }
            .onEnded { _ in
                scrollTimer?.invalidate()
                scrollTimer = nil

                withAnimation(.snappy(duration: 0.25, extraBounce: 0),
                              completionCriteria: .logicallyComplete) {
                    selectedControl?.frame = selectedControlFrame
                    selectedControlScale = 1.0
                    offset = .zero
                } completion: {
                    selectedControl = nil
                }
            }
    }
    
    private func checkAndSwapItems(_ location: CGPoint) {
        if let currentIndex = controls.firstIndex(where: { $0.id == selectedControl?.id }),
           let swapIndex = controls.firstIndex(where: { $0.frame.contains(location) }),
           currentIndex != swapIndex {
            withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                controls.swapAt(currentIndex, swapIndex)
            }
        }
    }
    
    private func checkAndScroll(location: CGPoint, proxy: ScrollViewProxy) {
        let scrollThreshold: CGFloat = 100
        
        guard let selectedControl = selectedControl else { return }
        
        // BoxView의 현재 프레임 계산
        let currentFrame = CGRect(
            x: selectedControl.frame.origin.x + offset.width,
            y: selectedControl.frame.origin.y + offset.height,
            width: selectedControl.frame.width,
            height: selectedControl.frame.height
        )
        
        // 상단, 하단 스크롤 영역 체크
        let topThreshold = scrollThreshold + safeArea.top
        let bottomThreshold = UIScreen.main.bounds.height - scrollThreshold - safeArea.bottom
        
        // BoxView의 top과 bottom 위치로 체크
        let isInTopRegion = currentFrame.minY <= topThreshold
        let isInBottomRegion = currentFrame.maxY >= bottomThreshold
        
        scrollTimer?.invalidate()
        scrollTimer = nil
        
        if isInTopRegion || isInBottomRegion {
            scrollManager.updateScrollOffset(isScrollingUp: isInTopRegion)

            if let currentIndex = controls.firstIndex(where: { $0.id == selectedControl.id }) {
                scrollManager.controls = controls
                scrollManager.currentIndex = currentIndex
                
                startScrolling(proxy: proxy)
            }
        }
    }
    
    private func startScrolling(proxy: ScrollViewProxy) {
        withAnimation(.linear(duration: scrollInterval).repeatForever(autoreverses: false)) {
            scrollManager.scroll(using: proxy)
        }
    }
}
