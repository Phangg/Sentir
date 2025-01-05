//
//  JournalIntentImp.swift
//  JournalFeature
//
//  Created by phang on 11/28/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Combine
import Foundation

import Common
import Core
import Domain

final class JournalIntentImp {
    //
    private weak var model: JournalModelAction?
    //
    @Injected(JournalUseCase.self)
    var journalStore: JournalUseCase
    // Combine
    var cancellables = Set<AnyCancellable>()

    //
    init(
        model: JournalModelAction
    ) {
        self.model = model
        self.fetchJournals()
    }
    
    //
    private func fetchJournals() {
        model?.updateLoadingState(true)
        //
        journalStore.fetchJournals()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.model?.updateLoadingState(false)
                case .failure(let error):
                    // TODO: - 에러 처리
                    fatalError("JournalListIntentImp - fetchJournals error \(error)")
                }
            } receiveValue: { [weak self] journals in
                self?.model?.updateJournals(journals)
            }
            .store(in: &cancellables)
    }
}

// MARK: - Intent
extension JournalIntentImp: JournalIntent {
    func openFilterSheet() {
        model?.updateShowFilterSheet(true)
    }
    
    func dismissFilterSheet() {
        model?.updateShowFilterSheet(false)
    }
    
    func toggleJournalViewMode(completion: @escaping () -> Void) {
        model?.toggleJournalViewMode()
        Just(())
            .delay(for: .seconds(0.25), scheduler: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &cancellables)
    }
    
    func onChangedCurrentJournalView(state: JournalViewState, date: Date) {
        switch state {
        case .calendar:
            let dateInfo = DateFormat.dateToDateInfoString(date)
            model?.updateListType(.day(dateInfo: dateInfo))
        case .list:
            model?.updateListType(.all)
        }
    }
    
    func resetSelectedMonthAndDates() {
        model?.updateSelectedMonthAndDates(Date())
    }
    
    func setValue(_ journals: [String: [Journal]]) {
        model?.updateJournals(journals)
    }
    
    func setValue(isLoading: Bool) {
        model?.updateLoadingState(isLoading)
    }
    
    func setValue(_ selectedMonthAndDates: Date) {
        model?.updateSelectedMonthAndDates(selectedMonthAndDates)
    }
    
    func setValue(showFilterSheet: Bool) {
        model?.updateShowFilterSheet(showFilterSheet)
    }
    
    func setValue(_ filterState: JournalFilterState) {
        model?.updateFilterState(filterState)
    }
    
    func updateListTypeToSearch(result: [String: [Journal]]) {
        model?.updateListType(.search(searchedJournals: result))
    }
    
    func finishedSearchView() {
        model?.updateListType(.all)
    }
}

// MARK: - JournalListIntent
extension JournalIntentImp {
    func deleteJournalItem(at indexSet: IndexSet, for dateInfo: String) {
        model?.updateLoadingState(true)
        //
        model?.deleteJournalItem(at: indexSet, for: dateInfo)
    }
}

// MARK: - JournalCalenderIntent
extension JournalIntentImp {
    func changeMonth(by direction: MonthMoveDirectionInCalendar) {
        model?.changeMonth(by: direction)
    }
    
    func onChangeMonth() {
        model?.updateCanMoveMonth(to: .next)
        model?.updateCanMoveMonth(to: .previous)
    }
    
    func tapCalenderCell(_ idx: Int, daysInMonth: Int) {
        model?.tapCalenderCell(idx, daysInMonth: daysInMonth)
    }
}
