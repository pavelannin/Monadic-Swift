import Foundation

/// The [Either] monad is a functional programming construct used to handle alternative results or errors.
/// It is a pair of values `Left` (for incorrect or alternative values) and `Right` (for correct ones).
/// The Either monad allows you to handle both variants in the same type.
/// This makes its application in error handling very useful.
public enum Either<Left, Right> {
    /// The left value of the monad is `Either`
    case left(Left)
    ///The right value of the monad is `Either`
    case right(Right)
}

public extension Either {
    /// Reduces nesting `Either`
    static func flatten(
        _ either: Either<Left, Either<Left, Right>>
    ) -> Either<Left, Right> {
        either.flatMap { $0 }
    }
    
    /// Converts the transformation function `transform` into a `Either` structure that returns a polymorphic function that can be
    /// applied to all values of `Either`.
    static func lift<Out>(
        _ transform: @escaping (Right) -> Out
    ) -> (Either<Left, Right>) -> Either<Left, Out> {
        { $0.map(transform) }
    }
    
    /// Converts transformation functions `left` and `right` into a `Either` structure that returns a polymorphic
    /// function that can be applied to all values of `Either`.
    static func lift<OutLeft, OutRight>(
        left leftTransform: @escaping (Left) -> OutLeft,
        right rightTransform: @escaping (Right) -> OutRight
    ) -> (Either<Left, Right>) -> Either<OutLeft, OutRight> {
        { $0.bimap(left: leftTransform, right: rightTransform) }
    }
    
    /// Transforms the right side [Either]
    func map<Out>(_ transform: (Right) -> Out) -> Either<Left, Out> {
        switch self {
        case let .left(value):
            return .left(value)
        case let .right(value):
            return .right(transform(value))
        }
    }
    
    /// Transforms the left side [Either]
    func mapLeft<Out>(_ transform: (Left) -> Out) -> Either<Out, Right> {
        switch self {
        case let .left(value):
            return .left(transform(value))
        case let .right(value):
            return .right(value)
        }
    }
    
    /// Transforms [Either]
    ///
    /// Applies `leftTransform` if it is `Either.left`, or `rightTransform` if it is `Either.right`
    func bimap<OutLeft, OutRight>(
        left leftTransform: (Left) -> OutLeft,
        right rightTransform: (Right) -> OutRight
    ) -> Either<OutLeft, OutRight> {
        switch self {
        case let .left(value):
            return .left(leftTransform(value))
        case let .right(value):
            return .right(rightTransform(value))
        }
    }
    
    /// Transforms `Either` to the value of `Result`
    ///
    /// Applies `leftTransform` if it is `Either.left`, or `rightTransform` if it is `Either.right`
    func fold<Result>(
        left leftTransform: (Left) -> Result,
        right rightTransform: (Right) -> Result
    ) -> Result {
        switch self {
        case let .left(value):
            return leftTransform(value)
        case let .right(value):
            return rightTransform(value)
        }
    }
    
    /// Transforms `Either` to the value of `Result`
    ///
    /// Applies `transform` if it is `Either.left`, or returns `right` if it is `Either.right`
    func foldLeft<Result>(
        _ rightValue: Result,
        _ transform: (Left) -> Result
    ) -> Result {
        switch self {
        case let .left(value):
            return transform(value)
        case .right(_):
            return rightValue
        }
    }
    
    /// Transforms `Either` to the value of `Result`
    ///
    /// Applies `transform` if it is `Either.right`, or returns `transform` if it is `Either.left`
    func foldRight<Result>(
        _ leftValue: Result,
        _ transform: (Right) -> Result
    ) -> Result {
        switch self {
        case .left(_):
            return leftValue
        case let .right(value):
            return transform(value)
        }
    }
    
    /// Transforms the right side `Either`
    func flatMap<Out>(
        _ transform: (Right) -> Either<Left, Out>
    ) -> Either<Left, Out> {
        switch self {
        case let .left(value):
            return .left(value)
        case let .right(value):
            return transform(value)
        }
    }
    
    // Transforms the left side `Either`
    func flatMapLeft<Out>(
        _ transform: (Left) -> Either<Out, Right>
    ) -> Either<Out, Right> {
        switch self {
        case let .left(value):
            return transform(value)
        case let .right(value):
            return .right(value)
        }
    }
    
    /// Combine two `Either` into one value with the transformation `transform`
    /// If both functions return `Either.right`, then the result will be `Either.right`, otherwise `Either.left`
    func zip<OtherRight, Result>(
        _ either: Either<Left, OtherRight>,
        _ transform: (Right, OtherRight) -> Result
    ) -> Either<Left, Result> {
        flatMap { right in either.map { otherRight in transform(right, otherRight) } }
    }
    
    /// If it is `Either.left`, then return the value of left to `Either.right` or vice versa
    func swap() -> Either<Right, Left> {
        fold(left: { .right($0) }, right: { .left($0) })
    }
    
    /// Returns a value if it is `Either.left`, or `nil` otherwise
    var left: Left? {
        switch self {
        case let .left(value):
            return value
        case .right(_):
            return nil
        }
    }
    
    /// Returns `true` if it is `Either.left`, or `false` otherwise
    var isLeft: Bool {
        switch self {
        case .left(_):
            return true
        case .right(_):
            return false
        }
    }
    
    /// Returns a value if it is `Either.right`, or `nil` otherwise
    var right: Right? {
        switch self {
        case .left(_):
            return nil
        case let .right(value):
            return value
        }
    }
    
    /// Returns `true` if it is `Either.right`, or `false` otherwise
    var isRight: Bool {
        switch self {
        case .left(_):
            return false
        case .right(_):
            return true
        }
    }
}

public extension Either where Left == Right {
    /// Returns a value if both sides contain the same type
    func take() -> Right {
        switch self {
        case let .left(value):
            return value
        case let .right(value):
            return value
        }
    }
}

public extension Either where Left: Error {
    init(_ closure: () throws -> Right) throws {
        do {
            self = .right(try closure())
        } catch let error {
            guard let value = error as? Left else { throw error }
            self = .left(value)
        }
    }
}

extension Either: Equatable where Left: Equatable, Right: Equatable {
    public static func == (lhs: Either<Left, Right>, rhs: Either<Left, Right>) -> Bool {
        switch (lhs, rhs) {
        case let (.left(lhs), .left(rhs)):
            return lhs == rhs
        case let (.right(lhs), .right(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}

extension Either: Comparable where Left: Comparable, Right: Comparable {
    public static func < (lhs: Either, rhs: Either) -> Bool {
        switch (lhs, rhs) {
        case let (.left(lhs), .left(rhs)):
            return lhs < rhs
        case let (.right(lhs), .right(rhs)):
            return lhs < rhs
        case (.left, .right):
            return true
        case (.right, .left):
            return false
        }
    }
}
