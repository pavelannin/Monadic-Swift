//
//  Either+Get.swift
//  Monadic
//
//  Created by Pavel Annin on 25.01.2025.
//

public extension Either {
    /// ###### EN:
    /// Returns `true` if it is `Either.left`, or `false` otherwise.
    ///
    ///###### RU:
    ///Возвращает значение `true`, если `Either.left`, в противном случае `false`.
    ///
    ///###### Example:
    /// ```
    /// Either<Int, Int>.right(1).isLeft // Result: false
    /// Either<Int, Int>.left(1).isLeft // Result: true
    /// ```
    var isLeft: Bool {
        if case .left = self { return true }
        return false
    }

    /// ###### EN:
    /// Returns `true` if it is `Either.right`, or `false` otherwise.
    ///
    /// ###### RU:
    /// Возвращает значение `true`, если `Either.right`, в противном случае `false`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1).isRight // Result: true
    /// Either<Int, Int>.left(1).isRight // Result: false
    /// ```
    var isRight: Bool {
        if case .right = self { return true }
        return false
    }

    /// ###### EN:
    /// Returns `value` if it is `Either.left`, or `nil` otherwise.
    ///
    /// ###### RU:
    /// Возвращает значение `value`, если `Either.left`, в противном случае `nil`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1).leftOrNil() // Result: nil
    /// Either<Int, Int>.left(1).leftOrNil() // Result: 1
    /// ```
    func leftOrNil() -> Left? {
        if case .left(let value) = self { return value }
        return nil
    }

    /// ###### EN:
    /// Returns `value` if it is `Either.right`, or `nil` otherwise.
    ///
    /// ###### RU:
    /// Возвращает значение `value`, если `Either.right`, в противном случае `nil`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.rightOrNil() // Result: 1
    /// Either<Int, Int>.rightOrNil() // Result: nil
    /// ```
    func rightOrNil() -> Right? {
        if case .right(let value) = self { return value }
        return nil
    }

    /// ###### EN:
    /// Returns `value` if it is `Either.left`, or `default` otherwise.
    ///
    /// ###### RU:
    /// Возвращает значение `value`, если `Either.left`, в противном случае `default`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1).leftOrDefault(2) // Result: 2
    /// Either<Int, Int>.left(1).leftOrDefault(2) // Result: 1
    /// ```
    func leftOrDefault(default value: Left) -> Left {
        if case .left(let left) = self { return left }
        return value
    }

    /// ###### EN:
    /// Returns `value` if it is `Either.right`, or `default` otherwise.
    ///
    /// ###### RU:
    /// Возвращает значение `value`, если `Either.right`, в противном случае `default`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.rightOrDefault(2) // Result: 1
    /// Either<Int, Int>.rightOrDefault(2) // Result: 2
    /// ```
    func rightOrDefault(default value: Right) -> Right {
        if case .right(let right) = self { return right }
        return value
    }

    /// ###### EN:
    /// Returns the value if `Either.left`, otherwise applies the `transform` function
    ///
    /// ###### RU:
    /// Возвращает значение, если `Either.left`, в противном случае применяет функцию `transform`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.left(1).leftOrElse { _ in 2 } // Result: 1
    /// Either<Int, Int>.right(1).leftOrElse { _ in 2 } // Result: 2
    /// ```
    func leftOrElse(_ transform: (Right) -> Left) -> Left {
        switch self {
        case let .left(left):
            return left

        case let .right(right):
            return transform(right)
        }
    }

    /// ###### EN:
    /// Returns the value if `Either.left`, otherwise applies the `transform` function
    ///
    /// ###### RU:
    /// Возвращает значение, если `Either.left`, в противном случае применяет функцию `transform`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.left(1).leftOrElse { _ in 2 } // Result: 1
    /// Either<Int, Int>.right(1).leftOrElse { _ in 2 } // Result: 2
    /// ```
    func leftOrElse(_ transform: (Right) async -> Left) async -> Left {
        switch self {
        case let .left(left):
            return left

        case let .right(right):
            return await transform(right)
        }
    }


    /// EN:
    /// Returns the value if `Either.right`, otherwise applies the `transform` function
    ///
    /// ###### RU:
    /// Возвращает значение, если `Either.right`, в противном случае применяет функцию `transform`.
    ///
    ///###### Example:
    /// ```
    /// Either<Int, Int>.left(1).rightOrElse { _ in 2 } // Result: 2
    /// Either<Int, Int>.right(1).rightOrElse { _ in 2 } // Result: 1
    /// ```
    func rightOrElse(_ transform: (Left) -> Right) -> Right {
        switch self {
        case let .left(left):
            return transform(left)

        case let .right(right):
            return right
        }
    }

    /// EN:
    /// Returns the value if `Either.right`, otherwise applies the `transform` function
    ///
    /// ###### RU:
    /// Возвращает значение, если `Either.right`, в противном случае применяет функцию `transform`.
    ///
    ///###### Example:
    /// ```
    /// Either<Int, Int>.left(1).rightOrElse { _ in 2 } // Result: 2
    /// Either<Int, Int>.right(1).rightOrElse { _ in 2 } // Result: 1
    /// ```
    func rightOrElse(_ transform: (Left) async -> Right) async -> Right {
        switch self {
        case let .left(left):
            return await transform(left)

        case let .right(right):
            return right
        }
    }
}

public extension Either where Left == Right {
    typealias Out = Right

    /// ###### Signature:
    /// `Either<Out, Out>` -> `Out`
    ///
    /// ###### EN:
    /// Returns a value if both sides contain the same type.
    ///
    /// ###### RU:
    /// Возвращает значение, если обе стороны содержат один и тот же тип.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1).take() // Result: 1
    /// Either<Int, Int>.left(2).take() // Result: 2
    /// ```
    func take() -> Out {
        switch self {
        case let .left(left):
            return left

        case let .right(right):
            return right
        }
    }
}
