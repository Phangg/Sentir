//
//  SearchBar.swift
//  JournalFeature
//
//  Created by phang on 9/13/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var searchState: JournalSearchState
    var isSearchFocused: FocusState<Bool>.Binding
    
    var body: some View {
        HStack {
            //
            TextField(
                "기록 내용 검색",
                text: $searchText,
                prompt: Text("기록 내용 검색")
                    .textStyle(Paragraph(color: DesignSystemAsset.lightGray)) as? Text
            )
            .padding(.trailing, ViewValues.largePadding)
            //
            .focused(isSearchFocused)
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
                    .opacity(searchText.isEmpty ? 0 : 1)
                    .onTapGesture {
                        searchText = ""
                        searchState = .none
                        isSearchFocused.wrappedValue = true
                    }
            }
            //
            .onSubmit {
                isSearchFocused.wrappedValue = false
                // TODO: - 수정 필요
                Task {
                    searchState = .isSearching
                    DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + 0.5) {
                        searchState = .finish
                    }
                }
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
