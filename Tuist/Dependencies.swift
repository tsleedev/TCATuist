//
//  Dependencies.swift
//  Config
//
//  Created by TAE SU LEE on 2023/07/03.
//

import ProjectDescription

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "0.55.0")),
    .remote(url: "https://github.com/Moya/Moya", requirement: .upToNextMajor(from: "15.0.0")),
    .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .upToNextMajor(from: "5.0.0")),
    .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "3.0.0")),
    .remote(url: "https://github.com/onevcat/Kingfisher", requirement: .upToNextMajor(from: "7.0.0")),
    .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .upToNextMajor(from: "6.0.0")),
])

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)
