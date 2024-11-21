//
//  FloatingTabBar.swift
//  MainTabFeature
//
//  Created by phang on 9/2/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem

struct FloatingTabBar: View {
    //
    @Namespace private var animation
    //
    @ObservedObject private var adapter: FloatingTabBarAdapter
    //
    private let activeForegroundColor: Color = DesignSystemAsset.white
    private let activeBackgroundColor: Color = DesignSystemAsset.lightGray
    private let tabBarHeight: CGFloat = 55
    private let tabItemWidth: CGFloat = 60
    private let tabItemHeight: CGFloat = 40
    
    //
    public init(
        adapter: FloatingTabBarAdapter
    ) {
        self._adapter = ObservedObject(wrappedValue: adapter)
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(TabType.allCases, id: \.self) { tab in
                Button {
                    adapter.intent.changeTab(to: tab)
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: tab.image)
                            .scaleEffect(adapter.state.currentTab == tab ? 1.1 : 0.9)
                            .font(.title2)
                            .fontWeight(.medium)
                            .frame(width: tabItemWidth, height: tabItemHeight)
                    }
                    .foregroundStyle(adapter.state.currentTab == tab ? activeForegroundColor : DesignSystemAsset.darkGray)
                    .padding(.vertical, ViewValues.tinyPadding)
                    .padding(.horizontal, ViewValues.mediumPadding)
                    .contentShape(.rect)
                    .background {
                        if adapter.state.currentTab == tab {
                            Capsule()
                                .fill(activeBackgroundColor.gradient)
                                .matchedGeometryEffect(id: "TABSELECTION", in: animation)
                        }
                    }
                }
                .buttonStyle(.plain)
                
                if tab != TabType.allCases.last {
                    Spacer()
                }
            }
        }
        .padding(.horizontal, ViewValues.halfPadding)
        .frame(height: tabBarHeight)
        .background(
            .background
                .shadow(.drop(color: DesignSystemAsset.gray008, radius: 5, x: 5, y: 5))
                .shadow(.drop(color: DesignSystemAsset.gray006, radius: 5, x: -5, y: -5)),
            in: .capsule
        )
        .animation(.smooth(duration: 0.3, extraBounce: 0), value: adapter.state.currentTab)
    }
}
