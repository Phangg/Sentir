//
//  JournalFilterView.swift
//  JournalFeature
//
//  Created by phang on 9/13/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem

struct JournalFilterView: View {
    @Binding var filterState: JournalFilterState
    @Binding var showFilterSheet: Bool
    
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
                    filterState = .newest
                    showFilterSheet.toggle()
                } label: {
                    HStack {
                        Text(JournalFilterState.newest.rawValue)
                            .textStyle(
                                Paragraph(
                                    weight: filterState == .newest ? .medium : .regular,
                                    color: filterState == .newest ? DesignSystemAsset.black : DesignSystemAsset.lightGray
                                )
                            )
                        Spacer()
                        Image(systemName: "checkmark")
                            .font(.callout)
                            .tint(filterState == .newest ? DesignSystemAsset.black : .clear)
                    }
                    .background(Color.clear)
                }
                .padding(.vertical, ViewValues.defaultPadding)
                //
                Divider()
                //
                Button {
                    filterState = .oldest
                    showFilterSheet.toggle()
                } label: {
                    HStack {
                        Text(JournalFilterState.oldest.rawValue)
                            .textStyle(
                                Paragraph(
                                    weight: filterState == .oldest ? .medium : .regular,
                                    color: filterState == .oldest ? DesignSystemAsset.black : DesignSystemAsset.lightGray
                                )
                            )
                        Spacer()
                        Image(systemName: "checkmark")
                            .font(.callout)
                            .tint(filterState == .oldest ? DesignSystemAsset.black : .clear)
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
