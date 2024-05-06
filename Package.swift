// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Monadic",
    products: [
        .library(name: "Monadic", targets: ["Monadic"]),
    ],
    dependencies: [
        .package(name: "MonadicMonadsEither", path: "Monads/Either"),
    ],
    targets: [
        .target(name: "Monadic", dependencies: ["MonadicMonadsEither"]),
    ]
)
