//
//  MainTabView.swift
//  MainTabFeature
//
//  Created by phang on 8/28/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem
import JournalFeature
import MainFeature
import SettingFeature

public struct MainTabView: View {
    @EnvironmentObject private var tabBarState: TabBarState
    @State private var tabSelection: Tab = .main
    @State private var isDefaultTabBarHidden: Bool = false
    
    public init() { }

    public var body: some View {
        ZStack(alignment: .bottom) {
            // Hidden 되어있는 TabBar
            Group {
                TabView(selection: $tabSelection) {
                    //
                    SentirMainView()
                        .tabItem {
                            Image(systemName: Tab.main.rawValue)
                        }
                        .background {
                            if !isDefaultTabBarHidden {
                                HideTabBar {
                                    isDefaultTabBarHidden = true
                                }
                            }
                        }
                        .tag(Tab.main)
                    //
                    JournalView()
                        .tabItem {
                            Image(systemName: Tab.journal.rawValue)
                        }
                        .tag(Tab.journal)
                    //
                    SettingView()
                        .tabItem {
                            Image(systemName: Tab.setting.rawValue)
                        }
                        .tag(Tab.setting)
                }
            }
            // 실제로 사용되는 TabBar
            if !tabBarState.isHidden {
                FloatingTabBar(tabSelection: $tabSelection)
                    .padding(.horizontal, ViewValues.largePadding)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

fileprivate struct HideTabBar: UIViewRepresentable {
    var result: () -> ()
    
    func makeUIView(
        context: Context
    ) -> some UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        DispatchQueue.main.async {
            if let tabController = view.tabController {
                tabController.tabBar.isHidden = true
            }
            result()
        }
        
        return view
    }
    
    func updateUIView(
        _ uiView: UIViewType,
        context: Context
    ) {
        //
    }
}
