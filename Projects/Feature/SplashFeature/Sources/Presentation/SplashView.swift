//
//  SplashView.swift
//  SplashFeature
//
//  Created by phang on 11/14/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import Combine

import Core

public struct SplashView: View {
    @StateObject var container: MVIContainer<SplashIntent, SplashModelState>
    private var intent: SplashIntent { container.intent }
    private var state: SplashModelState { container.model }
    //
    public var finishSplashPublisher: AnyPublisher<Void, Never> {
        (container.model as! SplashModelImp).finishSplashPublisher
    }
    
    public init(
        onFinishSplash: @escaping () -> Void
    ) {
        let model = SplashModelImp()
        let intent = SplashIntentImp(model: model)
        let container = MVIContainer(
            intent: intent as SplashIntent,
            model: model as SplashModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
        //
        model.finishSplashPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: onFinishSplash)
            .store(in: &model.cancellables)
    }
    
    public var body: some View {
        Text("SplashView")
            .onAppear {
                intent.viewOnAppear()
            }
    }
}
