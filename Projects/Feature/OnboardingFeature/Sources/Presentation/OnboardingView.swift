//
//  OnboardingView.swift
//  OnboardingFeature
//
//  Created by phang on 11/14/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

import Combine
import Common
import Core
import DesignSystem

public struct OnboardingView: View {
    @StateObject var container: MVIContainer<OnboardingIntent, OnboardingModelState>
    private var intent: OnboardingIntent { container.intent }
    private var state: OnboardingModelState { container.model }
    
    public init(
        finishOnboardingCompletion: @escaping () -> Void,
        configuration: OnboardingConfiguration = .default
    ) {
        let model = OnboardingModelImp()
        let intent = OnboardingIntentImp(
            model: model,
            configuration: configuration,
            finishOnboardingCompletion: finishOnboardingCompletion
        )
        let container = MVIContainer(
            intent: intent as OnboardingIntent,
            model: model as OnboardingModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }

    public var body: some View {
        VStack(alignment: .center, spacing: ViewValues.halfPadding) {
            Group {
                //
                CustomToolBar()
                //
                CustomTabIndicator()
            }
            .padding(.horizontal, ViewValues.defaultPadding)
            //
            TabView(selection: Binding(
                get: { state.currentPageType },
                set: { intent.moveToPage(by: .scroll, $0) })
            ) {
                //
                OnboardingPageView(.a)
                    .tag(OnboardingPageType.a)
                //
                OnboardingPageView(.b)
                    .tag(OnboardingPageType.b)
                //
                OnboardingPageView(.c)
                    .tag(OnboardingPageType.c)
            }
            .animation(.easeInOut(duration: 0.2), value: state.currentPageType)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .tint(DesignSystemAsset.black)
        }
        .onAppear {
            intent.viewOnAppear()
        }
        .onDisappear {
            intent.viewOnDisappear()
        }
    }
    
    @ViewBuilder
    fileprivate func CustomToolBar() -> some View {
        HStack(alignment: .center) {
            //
            Spacer()
            //
            Button {
                intent.finishOnboarding()
            } label: {
                Text(state.currentPageType.buttonType.rawValue)
                    .textStyle(Paragraph(weight: .medium))
            }
        }
    }
    
    @ViewBuilder
    fileprivate func CustomTabIndicator() -> some View {
        let indicatorFrameWidth = ViewValues.width - (ViewValues.defaultPadding * 2)
        //
        HStack(alignment: .center, spacing: ViewValues.halfPadding) {
            ForEach(OnboardingPageType.allCases, id: \.self) { type in
                Rectangle()
                    .fill(DesignSystemAsset.geyser)
                    .overlay(alignment: .leading) {
                        Rectangle()
                            .fill(type == state.currentPageType ? DesignSystemAsset.shuttleGray : .clear)
                            .frame(width: type == state.currentPageType ? (indicatorFrameWidth / 2) * state.progress : 0)
                    }
                    .frame(width: type == state.currentPageType ? indicatorFrameWidth / 2 : 10,
                           height: 10,
                           alignment: .center)
                    .clipShape(.rect(cornerRadius: 10))
                    .animation(.easeInOut(duration: 0.2), value: state.currentPageType)
                    .onTapGesture {
                        intent.moveToPage(by: .indicatorTap, type)
                    }
            }
        }
        .frame(width: indicatorFrameWidth, height: 30)
    }
    
    @ViewBuilder
    fileprivate func OnboardingPageView(_ type: OnboardingPageType) -> some View {
        VStack(alignment: .center, spacing: ViewValues.defaultPadding) {
            //
            Image(asset: type.image)
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .clipShape(.rect(cornerRadius: 10))
            //
            Text(type.description)
                .textStyle(SmallTitle(weight: .semibold))
        }
        .padding(.horizontal, ViewValues.defaultPadding)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    intent.pauseTimer()
                }
                .onEnded { _ in
                    intent.resumeTimer()
                }
        )
    }
}
