//
//  SettingView.swift
//  SettingFeature
//
//  Created by phang on 9/2/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import DesignSystem

public struct SettingView: View {
    @State private var toggleStates: [SettingModel: Bool] = [:]

    public init() { }

    public var body: some View {
        NavigationStack {
            //
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(SettingModel.allCases, id: \.self) { item in
                        //
                        HStack(alignment: .center) {
                            //
                            Text(item.rawValue)
                                .font(.callout)
                                .fontWeight(.regular)
                                .padding(.vertical, 10)
                            //
                            Spacer()
                            //
                            settingItemIcon(item)
                        }
                        //
                        if item == .font || item == .restoreData || item == .feedback || item == .openSource {
                            Rectangle()
                                .fill(.clear)
                                .frame(height: 20)
                        } else {
                            Divider()
                        }
                    }
                }
                .padding(20)
            }
            .safeAreaPadding(.bottom, 40)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar { settingViewToolbarContent() }
        }
        .tint(DesignSystemAsset.customBlack.swiftUIColor)
    }
    
    @ViewBuilder
    private func settingItemIcon(_ item: SettingModel) -> some View {
        switch item.type {
        case .navigate:
            Button {
                //
            } label: {
                Image(systemName: "chevron.right")
                    .font(.callout)
            }
        case .toggle:
            Toggle("", isOn: Binding(
                get: { toggleStates[item] ?? false },
                set: { toggleStates[item] = $0 }
            ))
            .labelsHidden()
        case .text:
            // TODO: -
            Text("1.0.0")
                .font(.callout)
        }
    }
    
    @ToolbarContentBuilder
    private func settingViewToolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Text("설정")
                .font(.title2)
                .padding(20)
        }
    }
}

#Preview {
    SettingView()
}
