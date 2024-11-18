//
//  Dependency+Feature.swift
//  AppManifests
//
//  Created by phang on 8/27/24.
//

import ProjectDescription

public extension Array<TargetDependency> {
    enum Presentation: String, CaseIterable {
        case splash, onboarding, main, journal, setting, journalHandler
        
        public var dependency: TargetDependency {
            var name = rawValue.map { $0 }
            name.removeFirst()
            name.insert(Character(rawValue.first!.uppercased()), at: 0)
            return presentationModule(name: "\(String(name))Feature")
        }
        
        private func presentationModule(name: String) -> TargetDependency {
            .project(
                target: "\(name)",
                path: .relativeToRoot("Projects/Feature/\(name)")
            )
        }
    }
}
