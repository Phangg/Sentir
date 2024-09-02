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
    @State private var tabSelection: Tab = .main
    @State private var isTabBarHidden: Bool = false
    
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
                            if !isTabBarHidden {
                                HideTabBar {
                                    isTabBarHidden = true
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
            FloatingTabBar(tabSelection: $tabSelection)
                .padding(.horizontal, 30)
        }
    }
}

public struct HideTabBar: UIViewRepresentable {
    public var result: () -> ()
    
    public func makeUIView(
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
    
    public func updateUIView(
        _ uiView: UIViewType,
        context: Context
    ) {
        //
    }
}

#Preview {
    MainTabView()
}
