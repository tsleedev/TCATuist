import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

/*
                +-------------+
                |             |
                |     App     | Contains TCATuist App target and TCATuist unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

let mainDependencies: [TargetDependency] = [
    .project(target: "TCATuistKit", path: "./"),
    .project(target: "TCATuistUI", path: "./")
]

let subTargets = [
    Target(
        name: "TCATuistKit",
        platform: .iOS,
        product: .framework,
        bundleId: "io.tuist.TCATuistKit",
        deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
        infoPlist: .default,
        sources: ["Targets/TCATuistKit/Sources/**"],
        dependencies: [
        ]
    ),
    Target(
        name: "TCATuistUI",
        platform: .iOS,
        product: .framework,
        bundleId: "io.tuist.TCATuistUI",
        deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
        infoPlist: .default,
        sources: ["Targets/TCATuistUI/Sources/**"],
        resources: ["Targets/TCATuistUI/Resources/**"],
        dependencies: [
            .project(target: "DataLayer", path: "./"),
            .external(name: "ComposableArchitecture")
        ]
    ),
    Target(
        name: "TSCore",
        platform: .iOS,
        product: .framework,
        bundleId: "io.tuist.TSCore",
        deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
        infoPlist: .default,
        sources: ["Targets/PlatformLayer/Sources/TSCore/**"],
        dependencies: [
            .project(target: "TSLogger", path: "./"),
            .external(name: "RxSwift"),
            .external(name: "RxCocoa")
        ]
    ),
    Target(
        name: "TSCoreUI",
        platform: .iOS,
        product: .framework,
        bundleId: "io.tuist.TSCoreUI",
        deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
        infoPlist: .default,
        sources: ["Targets/PlatformLayer/Sources/TSCoreUI/**"],
        resources: ["Targets/PlatformLayer/Sources/TSCoreUI/Resources/**"],
        dependencies: [
            .project(target: "TSCore", path: "./"),
            .project(target: "TSLogger", path: "./"),
            .external(name: "SnapKit"),
            .external(name: "Then"),
            .external(name: "Kingfisher")
        ]
    ),
    Target(
        name: "TSLogger",
        platform: .iOS,
        product: .framework,
        bundleId: "io.tuist.TSLogger",
        deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
        infoPlist: .default,
        sources: ["Targets/PlatformLayer/Sources/TSLogger/**"],
        dependencies: [
        ]
    ),
    Target(
        name: "DataLayer",
        platform: .iOS,
        product: .framework,
        bundleId: "io.tuist.DataLayer",
        deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
        infoPlist: .default,
        sources: ["Targets/DataLayer/Sources/**"],
        resources: [],
        dependencies: [
            .project(target: "TSCore", path: "./"),
            .external(name: "Moya"),
            .external(name: "CombineMoya")
        ]
    )
]

private func makeFrameworkTargets(name: String, platform: Platform = .iOS, dependencies: [TargetDependency] = [], needTests: Bool = false) -> [Target] {
    let sources = Target(name: name,
            platform: platform,
            product: .framework,
            bundleId: "io.tuist.\(name)",
            deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
            infoPlist: .default,
            sources: ["Targets/\(name)/Sources/**"],
            resources: [],
            dependencies: dependencies)
    if !needTests { return [sources] }
    
    let tests = Target(name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "io.tuist.\(name)Tests",
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            resources: [],
            dependencies: [.target(name: name)])
    return [sources, tests]
}

// Creates our project using a helper function defined in ProjectDescriptionHelpers

//let frameworkTargets = [
//    makeFrameworkTargets(name: "TCATuistKit"),
//    makeFrameworkTargets(name: "TCATuistUI", dependencies: [
//        .project(target: "DataLayer", path: "./")
//    ]),
//    makeFrameworkTargets(name: "TSCore", dependencies: [
//        .project(target: "TSLogger", path: "./"),
//        .external(name: "RxSwift"),
//        .external(name: "RxCocoa")
//    ]),
//    makeFrameworkTargets(name: "TSCoreUI", dependencies: [
//        .project(target: "TSCore", path: "./"),
//        .project(target: "TSLogger", path: "./"),
//        .external(name: "SnapKit"),
//        .external(name: "Then"),
//        .external(name: "Kingfisher")
//    ]),
//    makeFrameworkTargets(name: "TSLogger", dependencies: [
//        .project(target: "TSLogger", path: "./"),
//        .external(name: "RxSwift"),
//        .external(name: "RxCocoa")
//    ]),
//    makeFrameworkTargets(name: "DataLayer", dependencies: [
//        .project(target: "TSCore", path: "./"),
//        .external(name: "Moya"),
//        .external(name: "CombineMoya")
//    ]),
//]

let project = Project.app(name: "TCATuist",
                          platform: .iOS,
                          mainDependencies: mainDependencies,
                          subTargets: subTargets)
