//
//  SentirMainView.swift
//  MainFeature
//
//  Created by phang on 9/2/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

import Core
import Common
import DesignSystem
import JournalHandlerFeature

// MARK: - View
public struct SentirMainView: View {
    //
    @AppStorage("AppScheme") private var appScheme: AppScheme = .device
    @Environment(\.colorScheme) private var colorScheme
    //
    @StateObject var container: MVIContainer<MainIntent, MainModelState>
    private var intent: MainIntent { container.intent }
    private var state: MainModelState { container.model }
    
    public init() {
        let scrollService = MainViewScrollServiceImp()
        let model = MainModelImp()
        let intent = MainIntentImp(
            model: model,
            scrollService: scrollService
        )
        let container = MVIContainer(
            intent: intent as MainIntent,
            model: model as MainModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }
    
    public var body: some View {
        GeometryReader { geo in
            let safeArea = geo.safeAreaInsets
            //
            NavigationStack {
                //
                MainContent(safeArea: safeArea)
                    .safeAreaPadding(.bottom, ViewValues.bottomTabArea + ViewValues.largePadding)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden()
                    .toolbar { mainViewToolbarContent() }
            }
            .onChange(of: appScheme) { _, _ in
                updateScheme()
                // schemeChange
            }
            .onAppear {
                updateScheme()
                // viewOnAppear
            }
        }
    }
}

// MARK: - Components
extension SentirMainView {
    @ToolbarContentBuilder
    fileprivate func mainViewToolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack {
                //
                Text("Sentir")
                    .textStyle(Header(weight: .bold))
                    .padding(.horizontal, ViewValues.halfPadding)
                //
                Spacer()
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                // TODO: - 온보딩 다시 보기
                // tabQuestionmarkButton
            } label: {
                Image(systemName: "questionmark.circle")
                    .tint(DesignSystemAsset.black)
                    .padding(.horizontal, ViewValues.halfPadding)
            }
        }
    }
    
    @ViewBuilder
    private func MainContent(safeArea: EdgeInsets) -> some View {
        ScrollViewReader { proxy in
            ScrollView {
                //
                LazyVStack(spacing: 20) {
                    ForEach(Array(state.controls.enumerated()), id: \.element.id) { index, control in
                        //
                        NavigationLink(value: control) {
                            //
                            ControlBoxView(control: control)
                                .padding(.top, index == 0 ? ViewValues.defaultPadding : 0)
                                .padding(.bottom, index == state.controls.count - 1 ? ViewValues.defaultPadding : 0)
                                .opacity(state.selectedControl?.id == control.id ? 0 : 1)
                                .onGeometryChange(for: CGRect.self) {
                                    $0.frame(in: .global)
                                } action: { newValue in
                                    intent.handleControlBoxGeoChange(control: control,
                                                                     newFrame: newValue,
                                                                     controlIndex: index)
                                }
                                .gesture(
                                    customCombinedGesture(control, proxy: proxy, safaArea: safeArea)
                                )
                                .id(control.type)
                        }
                        .animation(.snappy(duration: 0.25, extraBounce: 0), value: state.controls)
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
            .onChange(of: state.selectedControlScale) { oldValue, newValue in
                print("selectedControlScale changed: \(oldValue) -> \(newValue)")
            }
        }
    }
    
    @ViewBuilder
    private var DraggedControlOverlay: some View {
        if let selectedControl = state.selectedControl {
            ControlBoxView(control: selectedControl)
                .frame(width: selectedControl.frame.width,
                       height: selectedControl.frame.height)
                .scaleEffect(state.selectedControlScale)
//                .animation(.smooth(duration: 0.25, extraBounce: 0), value: state.selectedControlScale)
                .position(x: selectedControl.frame.midX,
                          y: selectedControl.frame.midY)
                .offset(state.dragOffset)
                .ignoresSafeArea()
        }
    }
}

extension SentirMainView {
    private func customCombinedGesture(
        _ control: JournalContentControl,
        proxy: ScrollViewProxy,
        safaArea: EdgeInsets
    ) -> some Gesture {
        LongPressGesture(minimumDuration: 0.25)
            .sequenced(before: DragGesture(minimumDistance: 0, coordinateSpace: .global))
            .onChanged { value in
                switch value {
                case .second(let status, let dragValue):
                    if status {
                        if state.selectedControl == nil {
                            intent.handleControlSelect(control)
                        }
                        if let dragValue = dragValue,
                           let selectedControl = state.selectedControl {
                            intent.updateDragOffset(dragValue.translation)
                            intent.handleAutoScroll(location: dragValue.location,
                                                    proxy: proxy,
                                                    safeArea: safaArea,
                                                    selectedControl: selectedControl,
                                                    controls: state.controls,
                                                    offset: state.dragOffset)
                            intent.checkAndSwapItems(location: dragValue.location)
                        }
                    }
                default:
                    break
                }
            }
            .onEnded { _ in
                intent.handleDragEnded()
                intent.clearSelectedControl()
            }
    }
    
    private func updateScheme() {
        if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow {
            window.overrideUserInterfaceStyle = appScheme == .dark ? .dark : appScheme == .light ? .light : .unspecified
        }
    }
}
