//
//  Project.swift
//  AppManifests
//
//  Created by phang on 8/28/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "MainTabFeature",
    moduleType: .feature,
    dependencies: .Presentation.allCases.map { $0.dependency }
)
