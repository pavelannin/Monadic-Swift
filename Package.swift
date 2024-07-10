// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Monadic",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .driverKit(.v19)
    ],
    products: [
        .library(name: "Monadic", targets: ["MonadicMonadsEither"]),
    ],
    targets: [
        .target(name: "MonadicMonadsEither", path: "Monads/Either/Sources"),
    ]
)
