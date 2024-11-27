//
//  SchemePickerView.swift
//  SettingFeature
//
//  Created by phang on 9/2/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

import Common
import Core
import DesignSystem

public struct SchemePickerView: View {
    @StateObject var container: MVIContainer<SchemeIntent, SchemeModelState>
    private var intent: SchemeIntent { container.intent }
    private var state: SchemeModelState { container.model }

    //
    public init(
        previews: [SchemePreview]
    ) {
        let model = SchemeModelImp(previews: previews)
        let intent = SchemeIntentImp(
            model: model
        )
        let container = MVIContainer(
            intent: intent as SchemeIntent,
            model: model as SchemeModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            //
            Text("다크 모드 / 라이트 모드")
                .textStyle(SmallTitle(weight: .medium))
            //
            Spacer(minLength: 0)
            //
            GeometryReader { _ in
                HStack(spacing: 0) {
                    // 다크, 라이트
                    ForEach(state.previews) { preview in
                        SchemeCardView([preview], schemeType: preview.text == AppScheme.dark.rawValue ? .dark : .light)
                    }
                    // 사용자 기기
                    SchemeCardView(state.previews, schemeType: .device)
                }
            }
        }
        .padding(ViewValues.defaultPadding)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background {
            ZStack {
                Rectangle()
                    .fill(.background)
                Rectangle()
                    .fill(.primary.opacity(0.05))
            }
            .clipShape(.rect(cornerRadius: 20))
        }
        .padding(.horizontal, ViewValues.defaultPadding)
        .presentationDetents([.height(320)])
        .presentationBackground(.clear)
        .animation(.easeInOut(duration: 0.25), value: intent.appScheme)
    }
}

// MARK: -
extension SchemePickerView {
    @ViewBuilder
    fileprivate func SchemeCardView(
        _ previews: [SchemePreview],
        schemeType: AppScheme
    ) -> some View {
        //
        VStack(spacing: 6) {
            if let image = previews.first?.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        if schemeType == .device,
                           let secondImage = previews.last?.image {
                            GeometryReader { geo in
                                Image(uiImage: secondImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .mask(alignment: .trailing) {
                                        Rectangle()
                                            .frame(width: geo.size.width / 2)
                                    }
                            }
                        }
                    }
                    .clipShape(.rect(cornerRadius: 15))
            }
            // 설명 텍스트 값 할당
            let text = schemeType == .device ? AppScheme.device.rawValue : previews.first?.text ?? ""
            // 텍스트
            Text(text)
                .font(.caption)
                .tint(DesignSystemAsset.darkGray)
            // 체크 마크
            ZStack {
                if state.localSchemeState.rawValue == text {
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
            intent.tapSchemeCard(previews, schemeType: schemeType)
        }
    }
}
