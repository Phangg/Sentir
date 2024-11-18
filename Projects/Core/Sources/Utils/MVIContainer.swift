//
//  MVIContainer.swift
//  Core
//
//  Created by phang on 11/15/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import Combine

public final class MVIContainer<Intent, Model>: ObservableObject {
    //
    public let intent: Intent
    public let model: Model
    //
    private var cancellable: Set<AnyCancellable> = []

    //
    public init(
        intent: Intent,
        model: Model,
        modelChangePublisher: ObjectWillChangePublisher
    ) {
        self.intent = intent
        self.model = model

        modelChangePublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: objectWillChange.send)
            .store(in: &cancellable)
    }
}
