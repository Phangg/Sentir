//
//  SchemePickerView.swift
//  SettingFeature
//
//  Created by phang on 9/2/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem

public struct SchemePickerView: View {
    // 다크 모드 / 라이트 모드 설정
    @AppStorage("AppScheme") private var appScheme: AppScheme = .device
    // 미리보기 화면
    @Binding var previews: [SchemePreview]
    //
    @State private var localSchemeState: AppScheme = .device
    
    public init(
        previews: Binding<[SchemePreview]>
    ) {
        self._previews = previews
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            //
            Text("다크 모드 / 라이트 모드")
                .font(.headline)
                .fontWeight(.medium)
            //
            Spacer(minLength: 0)
            //
            GeometryReader { _ in
                HStack(spacing: 0) {
                    // 다크, 라이트
                    ForEach(previews) { preview in
                        SchemeCardView([preview])
                    }
                    // 사용자 기기
                    SchemeCardView(previews)
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .topLeading)
        .background {
            ZStack {
                Rectangle()
                    .fill(.background)
                Rectangle()
                    .fill(.primary.opacity(0.05))
            }
            .clipShape(.rect(cornerRadius: 20))
        }
        .padding(.horizontal, 20)
        .presentationDetents([.height(320)])
        .presentationBackground(.clear)
        .onChange(of: appScheme, initial: true) { oldValue, newValue in
            localSchemeState = newValue
        }
        .animation(.easeInOut(duration: 0.25), value: appScheme)
    }
    
    @ViewBuilder
    fileprivate func SchemeCardView(_ preview: [SchemePreview]) -> some View {
        VStack(spacing: 6) {
            if let image = preview.first?.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        if let secondImage = preview.last?.image, preview.count == 2 {
                            GeometryReader {
                                let width = $0.size.width / 2
                                
                                Image(uiImage: secondImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .mask(alignment: .trailing) {
                                        Rectangle()
                                            .frame(width: width)
                                    }
                            }
                        }
                    }
                    .clipShape(.rect(cornerRadius: 15))
            }
            // 설명 텍스트 값 할당
            let text = preview.count == 2 ? AppScheme.device.rawValue : preview.first?.text ?? ""
            // 텍스트
            Text(text)
                .font(.caption)
                .tint(DesignSystemAsset.darkGray)
            // 체크 마크
            ZStack {
                if localSchemeState.rawValue == text {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(DesignSystemAsset.black)
                        .transition(.blurReplace)
                }
                
                Image(systemName: "circle")
            }
        }
        .frame(maxWidth: .infinity)
        .contentShape(.rect)
        .onTapGesture {
            if preview.count == 2 {
                appScheme = .device
            } else {
                appScheme = preview.first?.text == AppScheme.dark.rawValue ? .dark : .light
            }
            //
            updateScheme()
        }
    }
    
    private func updateScheme() {
        if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow {
            window.overrideUserInterfaceStyle = appScheme == .dark ? .dark : appScheme == .light ? .light : .unspecified
        }
    }
}
