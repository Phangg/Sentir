import ProjectDescription

let project = Project(
    name: "Sentir",
    targets: [
        .target(
            name: "Sentir",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.Sentir",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["Sentir/Sources/**"],
            resources: ["Sentir/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "SentirTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.SentirTests",
            infoPlist: .default,
            sources: ["Sentir/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Sentir")]
        ),
    ]
)
