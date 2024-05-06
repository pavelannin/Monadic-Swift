// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Monadic",
    products: [
        .library(name: "Monadic", targets: ["MonadicMonadsEither"]),
    ],
    targets: [
        .target(name: "MonadicMonadsEither", path: "Monads/Either/Sources"),
    ]
)
