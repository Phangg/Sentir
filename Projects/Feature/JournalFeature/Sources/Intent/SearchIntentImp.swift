//
//  SearchIntentImp.swift
//  JournalFeature
//
//  Created by phang on 12/12/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Combine
import Dispatch

import Common
import Core
import Domain

final class SearchIntentImp {
    //
    private weak var model: SearchModelAction?
    //
    @Injected(TabBarStateManageable.self)
    var tabBarState: TabBarStateManageable
    @Injected(JournalUseCase.self)
    var journalStore: JournalUseCase
    // Combine
    var cancellables = Set<AnyCancellable>()
    // SearchIntent Property
    var handleSearchCompletion: ([String: [Journal]]) -> Void
    var finalizeSearchFlow: () -> Void
    
    //
    init(
        model: SearchModelAction,
        handleSearchCompletion: @escaping ([String: [Journal]]) -> Void,
        finalizeSearchFlow: @escaping () -> Void
    ) {
        self.model = model
        self.handleSearchCompletion = handleSearchCompletion
        self.finalizeSearchFlow = finalizeSearchFlow
    }
    
    //
    @MainActor
    private func hideTabBar() {
        tabBarState.hide()
    }
    
    @MainActor
    private func showTabBar() {
        tabBarState.show()
    }
}

// MARK: - Intent
extension SearchIntentImp: SearchIntent {
    @MainActor
    func viewOnAppear() {
        activateSearchFocus()
        hideTabBar()
    }
    
    @MainActor
    func tapBackButton() {
        finalizeSearchFlow()
        showTabBar()
    }
    
    func activateSearchFocus() {
        model?.updateSearchFocused(true)
    }
    
    func deactivateSearchFocus() {
        model?.updateSearchFocused(false)
    }
    
    func tapXmarkButton() {
        model?.updateSearchText("")
        model?.updateSearchState(.none)
        model?.updateSearchFocused(true)
    }
    
    func submitSearchBar(_ text: String) {
        model?.updateSearchFocused(false)
        model?.updateSearchState(.isSearching)
        //
        journalStore.searchJournals(text: text)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // TODO: - 에러 처리
                    self?.model?.updateSearchState(.none)
                    fatalError("SearchIntentImp - searchJournals error \(error)")
                }
            } receiveValue: { [weak self] searchedJournals in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if searchedJournals.isEmpty {
                        self?.model?.updateSearchState(.noResult)
                    } else {
                        self?.model?.updateSearchState(.finish)
                    }
                    self?.handleSearchCompletion(searchedJournals)
                }
            }
            .store(in: &cancellables)
    }
    
    func setValue(_ searchText: String) {
        model?.updateSearchText(searchText)
    }
}
