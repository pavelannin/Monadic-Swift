// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Monadic",
    products: [
        .library(name: "Monadic-Monads-Either", targets: ["Monadic-Monads-Either"]),
    ],
    targets: [
        .target(name: "Monadic-Monads-Either"),
        .testTarget(name: "EitherTests", dependencies: ["Monadic-Monads-Either"]),
    ]
)
