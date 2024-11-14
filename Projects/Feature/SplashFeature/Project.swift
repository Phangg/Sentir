//
//  Project.swift
//  AppManifests
//
//  Created by phang on 11/14/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "SplashFeature",
    moduleType: .feature,
    dependencies: [
        .designSystem,
        .common
    ]
)
