//
//  Scheme.swift
//  AppManifests
//
//  Created by phang on 8/27/24.
//

import ProjectDescription

public extension Scheme {
    static func moduleScheme(name: String) -> Self {
        Scheme.scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            runAction: .runAction(configuration: .debug),
            archiveAction: .archiveAction(configuration: .release)
        )
    }
}
