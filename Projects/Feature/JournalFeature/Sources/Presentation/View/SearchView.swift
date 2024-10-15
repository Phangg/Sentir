//
//  SearchView.swift
//  JournalFeature
//
//  Created by phang on 9/13/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem

public struct SearchView: View {
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isSearchFocused: Bool
    @State private var searchText: String = ""
    @State private var searchState: JournalSearchState = .none
    
    public init() { }
    
    public var body: some View {
        ZStack {
            VStack {
                //
                SearchViewCustomToolBar
                //
                Spacer(minLength: 0)
                //
                switch searchState {
                case .none, .noResult:
                    Text(searchState == .none ? "" : "검색 결과가 없습니다.")
                        .textStyle(SmallTitle(weight: .medium))
                case .isSearching:
                    // TODO: -
                    ProgressView()
                case .finish:
                    // TODO: - 검색 결과 전달
                    ListView(listType: .search(searchText: searchText))
                        .padding(.horizontal, -ViewValues.defaultPadding)
                }
                //
                Spacer(minLength: 0)
            }
            .navigationBarBackButtonHidden()
            .padding(.horizontal, ViewValues.defaultPadding)
        }
        .onTapGesture {
            isSearchFocused = false
        }
    }
    
    @ViewBuilder
    fileprivate var SearchViewCustomToolBar: some View {
        HStack {
            //
            Button {
                self.dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .padding(.trailing, ViewValues.halfPadding)
            }
            //
            Spacer(minLength: 0)
            //
            SearchBar(searchText: $searchText,
                      searchState: $searchState,
                      isSearchFocused: $isSearchFocused)
        }
    }
}
