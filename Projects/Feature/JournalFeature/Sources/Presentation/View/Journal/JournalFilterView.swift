//
//  JournalFilterView.swift
//  JournalFeature
//
//  Created by phang on 9/13/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

import Common
import Core
import DesignSystem

struct JournalFilterView: View {
    @StateObject var container: MVIContainer<JournalFilterIntent, JournalFilterModelState>
    private var intent: JournalFilterIntent { container.intent }
    private var state: JournalFilterModelState { container.model }
    
    init(
        filterState: Binding<JournalFilterState>,
        showFilterSheet: Binding<Bool>
    ) {
        //
        let model = JournalFilterModelImp(
            filterState: filterState,
            showFilterSheet: showFilterSheet
        )
        let intent = JournalFilterIntentImp(model: model)
        let container = MVIContainer(
            intent: intent as JournalFilterIntent,
            model: model as JournalFilterModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            //
            Text("기록 정렬 스타일")
                .textStyle(SmallTitle(weight: .medium))
            //
            Spacer(minLength: 0)
            //
            VStack(alignment: .leading, spacing: 0) {
                //
                Button {
                    intent.tapFilterButton(.newest)
                } label: {
                    HStack {
                        Text(JournalFilterState.newest.rawValue)
                            .textStyle(
                                Paragraph(
                                    weight: state.filterState == .newest ? .medium : .regular,
                                    color: state.filterState == .newest ? DesignSystemAsset.black : DesignSystemAsset.lightGray
                                )
                            )
                        Spacer()
                        Image(systemName: "checkmark")
                            .font(.callout)
                            .tint(state.filterState == .newest ? DesignSystemAsset.black : .clear)
                    }
                    .background(Color.clear)
                }
                .padding(.vertical, ViewValues.defaultPadding)
                //
                CustomDivider(color: DesignSystemAsset.lightGray,
                              type: .horizontal(height: 0.3))
                //
                Button {
                    intent.tapFilterButton(.oldest)
                } label: {
                    HStack {
                        Text(JournalFilterState.oldest.rawValue)
                            .textStyle(
                                Paragraph(
                                    weight: state.filterState == .oldest ? .medium : .regular,
                                    color: state.filterState == .oldest ? DesignSystemAsset.black : DesignSystemAsset.lightGray
                                )
                            )
                        Spacer()
                        Image(systemName: "checkmark")
                            .font(.callout)
                            .tint(state.filterState == .oldest ? DesignSystemAsset.black : .clear)
                    }
                }
                .padding(.vertical, ViewValues.defaultPadding)
            }
        }
        .padding(ViewValues.defaultPadding)
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
        .padding(.horizontal, ViewValues.defaultPadding)
        .presentationDetents([.height(210)])
        .presentationBackground(.clear)
    }
}
