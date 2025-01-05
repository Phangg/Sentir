//
//  SearchView.swift
//  JournalFeature
//
//  Created by phang on 9/13/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

import Common
import Core
import DesignSystem

public struct SearchView: View {
    @Environment(\.dismiss) private var dismiss
    //
    @StateObject var container: MVIContainer<SearchIntent, SearchModelState>
    private var intent: SearchIntent { container.intent }
    private var state: SearchModelState { container.model }
    
    public init(
        handleSearchCompletion: @escaping ([String: [Journal]]) -> Void,
        finalizeSearchFlow: @escaping () -> Void
    ) {
        let model = SearchModelImp()
        let intent = SearchIntentImp(
            model: model,
            handleSearchCompletion: handleSearchCompletion,
            finalizeSearchFlow: finalizeSearchFlow
        )
        let container = MVIContainer(
            intent: intent as SearchIntent,
            model: model as SearchModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }
    
    public var body: some View {
        ZStack {
            VStack {
                //
                SearchViewCustomToolBar
                //
                Spacer(minLength: 0)
                //
                switch state.searchState {
                case .none, .noResult:
                    Text(state.searchState == .none ? "" : "검색 결과가 없습니다.")
                        .textStyle(SmallTitle(weight: .medium))
                case .isSearching:
                    // TODO: - progressview 만들어서 수정 예정
                    ProgressView()
                case .finish:
                    JournalListView()
                        .padding(.horizontal, -ViewValues.defaultPadding)
                }
                //
                Spacer(minLength: 0)
            }
            .navigationBarBackButtonHidden()
            .padding(.horizontal, ViewValues.defaultPadding)
        }
        .onTapGesture {
            intent.deactivateSearchFocus()
        }
        .onAppear {
            intent.viewOnAppear()
        }
    }
    
    @ViewBuilder
    fileprivate var SearchViewCustomToolBar: some View {
        HStack(spacing: ViewValues.halfPadding) {
            //
            BackButton(isCutstomView: true) {
                self.dismiss()
                intent.tapBackButton()
            }
            //
            SearchBar()
                .environmentObject(container)
        }
    }
}
