//
//  Project.swift
//  FeatureDependency
//
//  Created by phang on 8/28/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "FeatureDependency",
    moduleType: .dynamicFramework,
    dependencies: [
        .designSystem,
        .domain
    ]
)
