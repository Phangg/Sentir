//
//  JournalFilterModelImp.swift
//  JournalFeature
//
//  Created by phang on 12/10/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import Combine

import Common

final class JournalFilterModelImp: ObservableObject, JournalFilterModelState {
    @Binding private(set) var filterState: JournalFilterState
    @Binding private(set) var showFilterSheet: Bool
    
    //
    init(
        filterState: Binding<JournalFilterState>,
        showFilterSheet: Binding<Bool>
    ) {
        self._filterState = filterState
        self._showFilterSheet = showFilterSheet
    }
}

extension JournalFilterModelImp: JournalFilterModelAction {
    func updateFilterState(_ state: JournalFilterState) -> AnyPublisher<Void, Never> {
        Future<Void, Never> { [weak self] promise in
            DispatchQueue.main.async {
                self?.filterState = state
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func toggleShowFilterSheet() {
        showFilterSheet.toggle()
    }
}
