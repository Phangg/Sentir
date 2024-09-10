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
    
    public init() { }

    public var body: some View {
        NavigationStack {
            //
            VStack {
                //
                switch viewState {
                case .list:
                    //
                    ListView()
                        .transition(.opacity)
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
        }
        //
        .tint(DesignSystemAsset.black)
    }
    
    @ToolbarContentBuilder
    private func journalViewToolbarContent() -> some ToolbarContent{
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
                Button {
                    // TODO: -
                    print("검색")
                } label: {
                    Image(systemName: "magnifyingglass")
                        .tint(DesignSystemAsset.black)
                        .padding(.leading, 10)
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
