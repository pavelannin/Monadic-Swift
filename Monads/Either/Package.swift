// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "MonadicMonadsEither",
    products: [
        .library(name: "MonadicMonadsEither", targets: ["MonadicMonadsEither"]),
    ],
    targets: [
        .target(name: "MonadicMonadsEither"),
        .testTarget(name: "EitherTests", dependencies: ["MonadicMonadsEither"]),
    ]
)
