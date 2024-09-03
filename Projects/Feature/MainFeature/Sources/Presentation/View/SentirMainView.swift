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

    public init() { }

    public var body: some View {
        NavigationStack {
            //
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(1...30, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(DesignSystemAsset.lightGray)
                            .frame(height: 40)
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
            }
            .safeAreaPadding(.bottom, 70)
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
    }
    
    @ToolbarContentBuilder
    private func mainViewToolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack {
                //
                Image(uiImage: colorScheme == .dark ? DesignSystemAsset.darkSentir.image : DesignSystemAsset.lightSentir.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                //
                Spacer()
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                // TODO: -
                print("설명 보기")
            } label: {
                Image(systemName: "questionmark.circle")
                    .tint(DesignSystemAsset.black)
            }
        }
    }
    
    private func updateScheme() {
        if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow {
            window.overrideUserInterfaceStyle = appScheme == .dark ? .dark : appScheme == .light ? .light : .unspecified
        }
    }
}

#Preview {
    SentirMainView()
}
