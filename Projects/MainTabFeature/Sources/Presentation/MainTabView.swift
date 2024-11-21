//
//  MainTabView.swift
//  MainTabFeature
//
//  Created by phang on 8/28/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

import Core
import Common
import DesignSystem
import JournalFeature
import MainFeature
import SettingFeature

public struct MainTabView: View {
    //
    @StateObject var container: MVIContainer<MainTabIntent, MainTabModelState>
    private var intent: MainTabIntent { container.intent }
    private var state: MainTabModelState { container.model }
    
    public init( ) {
        let model = MainTabModelImp()
        let intent = MainTabIntentImp(
            model: model
        )
        let container = MVIContainer(
            intent: intent as MainTabIntent,
            model: model as MainTabModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            // Hidden 되어있는 TabBar
            Group {
                TabView(selection: Binding(
                    get: { state.currentTab },
                    set: { intent.changeTab(to: $0) })
                ) {
                    //
                    SentirMainView()
                        .tabItem {
                            Image(systemName: TabType.main.image)
                        }
                        .background {
                            if !state.isDefaultTabBarHidden {
                                HideTabBar { intent.removeDefaultTabBar() }
                            }
                        }
                        .tag(TabType.main)
                    //
                    JournalView()
                        .tabItem {
                            Image(systemName: TabType.journal.image)
                        }
                        .tag(TabType.journal)
                    //
                    SettingView()
                        .tabItem {
                            Image(systemName: TabType.setting.image)
                        }
                        .tag(TabType.setting)
                }
            }
            // 실제로 사용되는 TabBar
            if !state.tabBarState.isHidden {
                FloatingTabBar(
                    adapter: FloatingTabBarAdapter(intent: intent, state: state)
                )
                .padding(.horizontal, ViewValues.largePadding)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - 기존 디폴트 탭바를 가리기 위함
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
    ) { }
}
