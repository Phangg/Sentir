//
//  SearchBar.swift
//  JournalFeature
//
//  Created by phang on 9/13/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

import Common
import Core
import DesignSystem

struct SearchBar: View {
    @EnvironmentObject var container: MVIContainer<SearchIntent, SearchModelState>
    private var intent: SearchBarIntent { container.intent }
    private var state: SearchBarModelState { container.model }
    //
    @FocusState var isSearchFocused: Bool
    
    var body: some View {
        HStack {
            //
            TextField(
                "기록 내용 검색",
                text: Binding(
                    get: { state.searchText },
                    set: { intent.setValue($0) }),
                prompt: Text("기록 내용 검색")
                    .textStyle(Paragraph(color: DesignSystemAsset.lightGray)) as? Text
            )
            .padding(.trailing, ViewValues.largePadding)
            //
            .focused($isSearchFocused)
            //
            .fontWeight(.regular)
            .foregroundStyle(DesignSystemAsset.black)
            //
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .submitLabel(.search)
            //
            .overlay(alignment: .trailing) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(DesignSystemAsset.lightGray)
                    .opacity(state.searchText.isEmpty ? 0 : 1)
                    .onTapGesture {
                        intent.tapXmarkButton()
                    }
            }
            //
            .onSubmit {
                intent.submitSearchBar(state.searchText)
            }
            .onChange(of: state.isSearchFocused) { _, newState in
                isSearchFocused = newState
            }
        }
        .padding(.horizontal, ViewValues.mediumPadding)
        .padding(.vertical, ViewValues.halfPadding)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(DesignSystemAsset.darkGray.opacity(0.1))
        )
    }
}
