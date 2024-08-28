//
//  Config.swift
//  AppManifests
//
//  Created by phang on 8/28/24.
//

import ProjectDescription

let config = Config(
    compatibleXcodeVersions: .all,
    plugins: [
        .local(path: .relativeToRoot("Plugins/EnvironmentPlugin")),
        .local(path: .relativeToRoot("Plugins/DependencyPlugin"))
    ],
    generationOptions: .options()
)
