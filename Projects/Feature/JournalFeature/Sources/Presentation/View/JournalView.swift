//
//  JournalView.swift
//  JournalFeature
//
//  Created by phang on 9/2/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import DesignSystem

public struct JournalView: View {
    @State private var viewState: JournalViewState = .list
    @State private var filterState: JournalFilterState = .newest
    @State private var showFilterSheet: Bool = false
    
    public init() { }

    public var body: some View {
        NavigationStack {
            //
            VStack(alignment: .trailing, spacing: 0) {
                //
                switch viewState {
                case .list:
                    ZStack(alignment: .topTrailing) {
                        //
                        ListView()
                            .transition(.opacity)
                        //
                        VStack {
                            JournalListFilterButton()
                                .zIndex(1)
                            Spacer()
                        }
                    }
                case .calendar:
                    //
                    CalendarView()
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut, value: viewState)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar { journalViewToolbarContent() }
            //
            .navigationDestination(for: String.self) { value in
                switch value {
                case "SearchView":
                    SearchView()
                default:
                    fatalError()
                }
            }
        }
        // 최신순 / 과거순
        .sheet(isPresented: $showFilterSheet, onDismiss: {
            showFilterSheet = false
        }, content: {
            JournalFilterView(filterState: $filterState,
                              showFilterSheet: $showFilterSheet)
        })
        //
        .tint(DesignSystemAsset.black)
    }
    
    @ViewBuilder
    fileprivate func JournalListFilterButton() -> some View {
        //
        Button {
            showFilterSheet = true
        } label: {
            HStack(spacing: 6) {
                Text(filterState.rawValue)
                    .textStyle(Paragraph(weight: .medium))
                Image(systemName: "chevron.down")
                    .font(.callout)
                    .fontWeight(.medium)
            }
        }
        .padding(.top, 10)
        .padding(.horizontal, 20)
    }
    
    @ToolbarContentBuilder
    fileprivate func journalViewToolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            //
            Text("기록")
                .textStyle(Title())
                .padding(.horizontal, 10)
        }
        //
        if viewState == .list {
            ToolbarItem(placement: .topBarTrailing) {
                //
                NavigationLink(value: "SearchView") {
                    Image(systemName: "magnifyingglass")
                        .tint(DesignSystemAsset.black)
                }
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            //
            Button {
                // TODO: -
                withAnimation {
                    viewState = viewState == .list ? .calendar : .list
                }
            } label: {
                Image(systemName: viewState == .list ? "calendar": "list.dash")
                    .tint(DesignSystemAsset.black)
                    .padding(.trailing, 10)
            }
        }
    }
}

#Preview {
    JournalView()
}
