//
//  SentirMainView.swift
//  MainFeature
//
//  Created by phang on 9/2/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem

public struct SentirMainView: View {
    @AppStorage("AppScheme") private var appScheme: AppScheme = .device
    @Environment(\.colorScheme) private var colorScheme
    @State private var showDescription: Bool = false
    @Binding var isTabBarHidden: Bool

    public init(isTabBarHidden: Binding<Bool>) {
        self._isTabBarHidden = isTabBarHidden
    }

    public var body: some View {
        GeometryReader { geo in
            let safeArea = geo.safeAreaInsets
            //
            NavigationStack {
                //
                MainContentView(safeArea: safeArea)
                    .safeAreaPadding(.bottom, ViewValues.bottomTabArea + ViewValues.largePadding)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden()
                    .toolbar { mainViewToolbarContent() }
            }
            .onChange(of: appScheme) { _, _ in
                updateScheme()
            }
            .onAppear {
                updateScheme()
            }
            //
            if showDescription {
                DesignSystemAsset.darkGray.opacity(0.3)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        showDescription = false
                    }
            }
        }
    }
    
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
                showDescription = true
            } label: {
                Image(systemName: "questionmark.circle")
                    .tint(DesignSystemAsset.black)
                    .padding(.horizontal, ViewValues.halfPadding)
            }
        }
    }
    
    private func updateScheme() {
        if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow {
            window.overrideUserInterfaceStyle = appScheme == .dark ? .dark : appScheme == .light ? .light : .unspecified
        }
    }
}
