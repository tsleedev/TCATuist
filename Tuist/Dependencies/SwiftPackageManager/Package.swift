// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.55.0"),
        .package(url: "https://github.com/Moya/Moya", from: "15.0.0"),
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.0.0"),
        .package(url: "https://github.com/devxoul/Then", from: "3.0.0"),
        .package(url: "https://github.com/onevcat/Kingfisher", from: "7.0.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.0.0"),
    ]
)
