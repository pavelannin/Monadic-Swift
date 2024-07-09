import Foundation

public extension Either {
    /// Transforms the right side [Either]
    func map<Out>(_ transform: (Right) async -> Out) async -> Either<Left, Out> {
        switch self {
        case let .left(value):
            return .left(value)
        case let .right(value):
            return .right(await transform(value))
        }
    }
    
    /// Transforms the left side [Either]
    func mapLeft<Out>(_ transform: (Left) async -> Out) async -> Either<Out, Right> {
        switch self {
        case let .left(value):
            return .left(await transform(value))
        case let .right(value):
            return .right(value)
        }
    }
    
    /// Transforms [Either]
    ///
    /// Applies `leftTransform` if it is `Either.left`, or `rightTransform` if it is `Either.right`
    func bimap<OutLeft, OutRight>(
        left leftTransform: (Left) async -> OutLeft,
        right rightTransform: (Right) async -> OutRight
    ) async -> Either<OutLeft, OutRight> {
        switch self {
        case let .left(value):
            return .left(await leftTransform(value))
        case let .right(value):
            return .right(await rightTransform(value))
        }
    }
    
    /// Transforms `Either` to the value of `Result`
    ///
    /// Applies `leftTransform` if it is `Either.left`, or `rightTransform` if it is `Either.right`
    func fold<Result>(
        left leftTransform: (Left) async -> Result,
        right rightTransform: (Right) async -> Result
    ) async -> Result {
        switch self {
        case let .left(value):
            return await leftTransform(value)
        case let .right(value):
            return await rightTransform(value)
        }
    }
    
    /// Transforms `Either` to the value of `Result`
    ///
    /// Applies `transform` if it is `Either.left`, or returns `right` if it is `Either.right`
    func foldLeft<Result>(
        _ rightValue: Result,
        _ transform: (Left) async -> Result
    ) async -> Result {
        switch self {
        case let .left(value):
            return await transform(value)
        case .right(_):
            return rightValue
        }
    }
    
    /// Transforms `Either` to the value of `Result`
    ///
    /// Applies `transform` if it is `Either.right`, or returns `transform` if it is `Either.left`
    func foldRight<Result>(
        _ leftValue: Result,
        _ transform: (Right) async -> Result
    ) async -> Result {
        switch self {
        case .left(_):
            return leftValue
        case let .right(value):
            return await transform(value)
        }
    }
    
    /// Transforms the right side `Either`
    func flatMap<Out>(
        _ transform: (Right) async -> Either<Left, Out>
    ) async -> Either<Left, Out> {
        switch self {
        case let .left(value):
            return .left(value)
        case let .right(value):
            return await transform(value)
        }
    }
    
    // Transforms the left side `Either`
    func flatMapLeft<Out>(
        _ transform: (Left) async -> Either<Out, Right>
    ) async -> Either<Out, Right> {
        switch self {
        case let .left(value):
            return await transform(value)
        case let .right(value):
            return .right(value)
        }
    }
}
