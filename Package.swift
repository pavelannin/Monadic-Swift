// swift-tools-version: 6.0.0
import PackageDescription

let package = Package(
    name: "Monadic",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(name: "Monadic", targets: ["MonadicMonadsEither"]),
        .library(name: "Either", targets: ["MonadicEither"]),
        .library(name: "Result", targets: ["MonadicResult"]),
        .library(name: "LCE", targets: ["MonadicLCE"]),
    ],
    targets: [
        .target(name: "MonadicMonadsEither", path: "Monads/Either/Sources"),
        .target(name: "MonadicEither"),
        .testTarget(name: "EitherTests", dependencies: ["MonadicEither"]),
        .target(name: "MonadicResult"),
        .target(name: "MonadicLCE"),
    ]
)
