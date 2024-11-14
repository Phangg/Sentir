//
//  Project.swift
//  AppManifests
//
//  Created by phang on 8/28/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "JournalFeature",
    moduleType: .feature,
    dependencies: [
        .journalHandler,
    ]
)
