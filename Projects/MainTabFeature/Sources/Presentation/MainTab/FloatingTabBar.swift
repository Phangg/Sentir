//
//  FloatingTabBar.swift
//  MainTabFeature
//
//  Created by phang on 9/2/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import DesignSystem

public struct FloatingTabBar: View {
    @Namespace private var animation
    @Binding var tabSelection: Tab
    
    private var activeForegroundColor: Color = DesignSystemAsset.white
    private var activeBackgroundColor: Color = DesignSystemAsset.lightGray
    
    public init(tabSelection: Binding<Tab>) {
        self._tabSelection = tabSelection
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                Button {
                    tabSelection = tab
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: tab.rawValue)
                            .font(.title2)
                            .fontWeight(.medium)
                            .frame(width: 60, height: 40)
                    }
                    .foregroundStyle(tabSelection == tab ? activeForegroundColor : DesignSystemAsset.darkGray)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 15)
                    .contentShape(.rect)
                    .background {
                        if tabSelection == tab {
                            Capsule()
                                .fill(activeBackgroundColor.gradient)
                                .matchedGeometryEffect(id: "TABSELECTION", in: animation)
                        }
                    }
                }
                .buttonStyle(.plain)
                
                if tab != Tab.allCases.last {
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 10)
        .frame(height: 55)
        .background(
            .background
                .shadow(.drop(color: DesignSystemAsset.gray008, radius: 5, x: 5, y: 5))
                .shadow(.drop(color: DesignSystemAsset.gray006, radius: 5, x: -5, y: -5)),
            in: .capsule
        )
        .animation(.smooth(duration: 0.3, extraBounce: 0), value: tabSelection)
    }
}
