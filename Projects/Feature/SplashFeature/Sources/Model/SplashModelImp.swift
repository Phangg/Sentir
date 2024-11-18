//
//  SplashModelImp.swift
//  SplashFeature
//
//  Created by phang on 11/16/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation
import Combine

public final class SplashModelImp: ObservableObject, SplashModelState {
    //
    @Published var isLoading: Bool
    // combine
    private let finishSplashSubject = PassthroughSubject<Void, Never>()
    var finishSplashPublisher: AnyPublisher<Void, Never> {
        finishSplashSubject.eraseToAnyPublisher()
    }
    var cancellables = Set<AnyCancellable>()

    //
    init(
        isLoading: Bool = true
    ) {
        self.isLoading = isLoading
    }
}

extension SplashModelImp: SplashModelAction {
    func finishSplashFetch() {
        print("Splash - fetch 완료")
        isLoading = false
        finishSplashSubject.send()
    }
    
    func displayLoading() {
        isLoading = true
    }
    
    func displayError(_ error: any Error) {
        isLoading = false
        fatalError("Splash View Error - \(error)")
    }
}
