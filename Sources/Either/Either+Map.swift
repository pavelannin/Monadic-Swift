//
//  Either+Map.swift
//  Monadic
//
//  Created by Pavel Annin on 25.01.2025.
//

public extension Either {
    /// ###### Signature:
    /// `Either<Left, Right>` -> `Either<Left, Out>`
    ///
    /// ###### EN:
    /// Transforms to `Either<Left, Out>` by applying the `transform` function if `Either.right`.
    ///
    /// ###### RU:
    /// Трансформирует в `Either<Left, Out>`, применяя функцию `transform` если `Either.right`.
    ///
    ///###### Example:
    /// ```
    /// Either<Int, Int>.right(1).map { _ in "foo" } // Result: right("foo")
    /// Either<Int, Int>.left(1).map { _ in "foo" }  // Result: left(1)
    /// ```
    func map<Out>(_ transform: (Right) -> Out) -> Either<Left, Out> {
        switch self {
        case let .left(left):
            return .left(left)

        case let .right(right):
            return .right(transform(right))
        }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` -> `Either<Left, Out>`
    ///
    /// ###### EN:
    /// Transforms to `Either<Left, Out>` by applying the `transform` function if `Either.right`.
    ///
    /// ###### RU:
    /// Трансформирует в `Either<Left, Out>`, применяя функцию `transform` если `Either.right`.
    ///
    ///###### Example:
    /// ```
    /// Either<Int, Int>.right(1).map { _ in "foo" } // Result: right("foo")
    /// Either<Int, Int>.left(1).map { _ in "foo" }  // Result: left(1)
    /// ```
    func map<Out>(_ transform: (Right) async -> Out) async -> Either<Left, Out> {
        switch self {
        case let .left(left):
            return .left(left)

        case let .right(right):
            return .right(await transform(right))
        }
    }

    ///  ###### Signature:
    /// `Either<Left, Right>` -> `Either<Out, Right>`
    ///
    /// ###### EN:
    /// Transforms to `Either<Out, Right>` by applying the `transform` function if `Either.left`.
    ///
    /// ###### RU:
    /// Трансформирует в `Either<Out, Right>`, применяя функцию `transform` если `Either.left`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1).mapLeft { "foo" } // Result: right(1)
    /// Either<Int, Int>.left(1).mapLeft { "foo" }  // Result: left("foo")
    /// ```
    func mapLeft<Out>(_ transform: (Left) -> Out) -> Either<Out, Right> {
        switch self {
        case let .left(left):
            return .left(transform(left))

        case let .right(right):
            return .right(right)
        }
    }

    ///  ###### Signature:
    /// `Either<Left, Right>` -> `Either<Out, Right>`
    ///
    /// ###### EN:
    /// Transforms to `Either<Out, Right>` by applying the `transform` function if `Either.left`.
    ///
    /// ###### RU:
    /// Трансформирует в `Either<Out, Right>`, применяя функцию `transform` если `Either.left`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1).mapLeft { "foo" } // Result: right(1)
    /// Either<Int, Int>.left(1).mapLeft { "foo" }  // Result: left("foo")
    /// ```
    func mapLeft<Out>(_ transform: (Left) async -> Out) async -> Either<Out, Right> {
        switch self {
        case let .left(left):
            return .left(await transform(left))

        case let .right(right):
            return .right(right)
        }
    }

    ///  ###### Signature:
    /// `Either<Left, Right>` -> `Either<LeftOut, RightOut>`
    ///
    /// ###### EN:
    /// Transforms to `Either<LeftOut, RightOut>` by applying the `leftTransform` function
    /// if `Either.left`, or the `rightTransform` function if `right`.
    ///
    /// ###### RU:
    /// Трансформирует в `Either<LeftOut, RightOut>`, применяя функцию `leftTransform`
    /// если `Either.left`, или функцию `rightTransform` если `right`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1)
    ///     .bimap(left: { _ in "foo" }, right: { _ in "bar" }) // Result: right("bar")
    ///
    /// Either<Int, Int>.left(1)
    ///     .bimap(left: { _ in "foo" }, right: { _ in "bar" }) // Result: left("foo")
    /// ```
    func bimap<LeftOut, RightOut>(
        left leftTransform: (Left) -> LeftOut,
        right rightTransform: (Right) -> RightOut
    ) -> Either<LeftOut, RightOut> {
        switch self {
        case let .left(left):
            return .left(leftTransform(left))

        case let .right(right):
            return .right(rightTransform(right))
        }
    }

    ///  ###### Signature:
    /// `Either<Left, Right>` -> `Either<LeftOut, RightOut>`
    ///
    /// ###### EN:
    /// Transforms to `Either<LeftOut, RightOut>` by applying the `leftTransform` function
    /// if `Either.left`, or the `rightTransform` function if `right`.
    ///
    /// ###### RU:
    /// Трансформирует в `Either<LeftOut, RightOut>`, применяя функцию `leftTransform`
    /// если `Either.left`, или функцию `rightTransform` если `right`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1)
    ///     .bimap(left: { _ in "foo" }, right: { _ in "bar" }) // Result: right("bar")
    ///
    /// Either<Int, Int>.left(1)
    ///     .bimap(left: { _ in "foo" }, right: { _ in "bar" }) // Result: left("foo")
    /// ```
    func bimap<LeftOut, RightOut>(
        left leftTransform: (Left) async -> LeftOut,
        right rightTransform: (Right) async -> RightOut
    ) async -> Either<LeftOut, RightOut> {
        switch self {
        case let .left(left):
            return .left(await leftTransform(left))

        case let .right(right):
            return .right(await rightTransform(right))
        }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` -> `Out`
    ///
    /// ###### EN:
    /// Transforms to the value `Out`. Applies the `leftTransform` function if `Either.left`,
    /// or the `rightTransform` function if `Either.right`.
    ///
    /// ###### RU:
    /// Трансформирует в значение `Out`. Применяет функцию `leftTransform` если `Either.left`,
    /// или функцию `rightTransform` если `Either.right`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1)
    ///     .fold(left: { _ in "foo" }, right: { _ in "bar" }) // Result: "bar"
    ///
    /// Either<Int, Int>.left(1)
    ///     .fold(left: { "foo" }, right: { _ in "bar" }) // Result: "foo"
    /// ```
    func fold<Out>(
        left leftTransform: (Left) -> Out,
        right rightTransform: (Right) -> Out
    ) -> Out {
        switch self {
        case let .left(left):
            return leftTransform(left)

        case let .right(right):
            return rightTransform(right)
        }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` -> `Out`
    ///
    /// ###### EN:
    /// Transforms to the value `Out`. Applies the `leftTransform` function if `Either.left`,
    /// or the `rightTransform` function if `Either.right`.
    ///
    /// ###### RU:
    /// Трансформирует в значение `Out`. Применяет функцию `leftTransform` если `Either.left`,
    /// или функцию `rightTransform` если `Either.right`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1)
    ///     .fold(left: { _ in "foo" }, right: { _ in "bar" }) // Result: "bar"
    ///
    /// Either<Int, Int>.left(1)
    ///     .fold(left: { "foo" }, right: { _ in "bar" }) // Result: "foo"
    /// ```
    func fold<Out>(
        left leftTransform: (Left) async -> Out,
        right rightTransform: (Right) async -> Out
    ) async -> Out {
        switch self {
        case let .left(left):
            return await leftTransform(left)

        case let .right(right):
            return await rightTransform(right)
        }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` -> `Out`
    ///
    /// ###### EN:
    /// Transforms `Either<Left, Right>` to the value `Out`. Applies the `transform` function
    /// if `Either.left`, otherwise returns the value `initial`.
    ///
    /// ###### RU:
    /// Трансформирует в `Either<Left, Right>` в значение `Out`. Применяет функцию `transform`
    /// если `Either.left`, иначе возвращает значение `initial`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1)
    ///     .foldLeft(initial: "foo") { _ in "bar" }) // Result: "foo"
    ///
    /// Either<Int, Int>.left(1)
    ///     .foldLeft(initial: "foo") { _ in "bar" }) // Result: "bar"
    /// ```
    func foldLeft<Out>(initial: Out, transform: (Left) -> Out) -> Out {
        if case .left(let left) = self { return transform(left) }
        return initial
    }

    /// ###### Signature:
    /// `Either<Left, Right>` -> `Out`
    ///
    /// ###### EN:
    /// Transforms `Either<Left, Right>` to the value `Out`. Applies the `transform` function
    /// if `Either.left`, otherwise returns the value `initial`.
    ///
    /// ###### RU:
    /// Трансформирует в `Either<Left, Right>` в значение `Out`. Применяет функцию `transform`
    /// если `Either.left`, иначе возвращает значение `initial`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1)
    ///     .foldLeft(initial: "foo") { _ in "bar" }) // Result: "foo"
    ///
    /// Either<Int, Int>.left(1)
    ///     .foldLeft(initial: "foo") { _ in "bar" }) // Result: "bar"
    /// ```
    func foldLeft<Out>(initial: Out, transform: (Left) async -> Out) async -> Out {
        if case .left(let left) = self { return await transform(left) }
        return initial
    }

    /// ###### Signature:
    /// `Either<Left, Right>` -> `Out`
    ///
    /// ###### EN:
    /// Transforms `Either<Left, Right>` to the value `Out`. Applies the `transform` function
    /// if `Either.right`, otherwise returns the value `initial`.
    ///
    /// ###### RU:
    /// Трансформирует в `Either<Left, Right>` в значение `Out`. Применяет функцию `transform`
    /// если `Either.right`, иначе возвращает значение `initial`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1)
    ///     .foldRight(initial: "foo") { _ in "bar" } // Result: "bar"
    ///
    /// Either<Int, Int>.left(1)
    ///     .foldRight(initial: "foo") { _ in "bar" } // Result: "foo"
    /// ```
    func foldRight<Out>(initial: Out, transform: (Right) -> Out) -> Out {
        if case .right(let right) = self { return transform(right) }
        return initial
    }

    /// ###### Signature:
    /// `Either<Left, Right>` -> `Out`
    ///
    /// ###### EN:
    /// Transforms `Either<Left, Right>` to the value `Out`. Applies the `transform` function
    /// if `Either.right`, otherwise returns the value `initial`.
    ///
    /// ###### RU:
    /// Трансформирует в `Either<Left, Right>` в значение `Out`. Применяет функцию `transform`
    /// если `Either.right`, иначе возвращает значение `initial`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1)
    ///     .foldRight(initial: "foo") { _ in "bar" } // Result: "bar"
    ///
    /// Either<Int, Int>.left(1)
    ///     .foldRight(initial: "foo") { _ in "bar" } // Result: "foo"
    /// ```
    func foldRight<Out>(initial: Out, transform: (Right) async -> Out) async -> Out {
        if case .right(let right) = self { return await transform(right) }
        return initial
    }

    /// ###### Signature:
    /// `Either<Left, Right>` -> `Either<Left, Out>`
    ///
    /// ###### EN:
    /// Transforms to `Either<Left, Out>` by applying the `transform` function if `Either.right`.
    ///
    /// ###### RU:
    /// Трансформирует в `Either<Left, Out>`, применяя функцию `transform` если `Either.right`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1).flatMap { _ in .right("bar") } // Result: right("bar")
    /// Either<Int, Int>.right(1).flatMap { _ in .left("zoo") } // Result: left("zoo")
    ///
    /// Either<Int, Int>.left(1).flatMap { _ in  .right("bar") } // Result: left(1)
    /// Either<Int, Int>.left(1).flatMap { _ in  .left("zoo") } // Result: left(1)
    /// ```
    func flatMap<Out>(_ transform: (Right) -> Either<Left, Out>) -> Either<Left, Out> {
        switch self {
        case let .left(left):
            return .left(left)

        case let .right(right):
            return transform(right)
        }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` -> `Either<Left, Out>`
    ///
    /// ###### EN:
    /// Transforms to `Either<Left, Out>` by applying the `transform` function if `Either.right`.
    ///
    /// ###### RU:
    /// Трансформирует в `Either<Left, Out>`, применяя функцию `transform` если `Either.right`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1).flatMap { _ in .right("bar") } // Result: right("bar")
    /// Either<Int, Int>.right(1).flatMap { _ in .left("zoo") } // Result: left("zoo")
    ///
    /// Either<Int, Int>.left(1).flatMap { _ in  .right("bar") } // Result: left(1)
    /// Either<Int, Int>.left(1).flatMap { _ in  .left("zoo") } // Result: left(1)
    /// ```
    func flatMap<Out>(_ transform: (Right) async -> Either<Left, Out>) async -> Either<Left, Out> {
        switch self {
        case let .left(left):
            return .left(left)

        case let .right(right):
            return await transform(right)
        }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` -> `Either<Out, Right>`
    ///
    /// ###### EN:
    /// Transforms to `Either<Out, Right>` by applying the `transform` function if `Either.left`.
    ///
    /// ###### RU:
    /// Трансформирует в `Either<Out, Right>`, применяя функцию `transform` если `Either.left`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1).flatMapLeft { _ in .right("bar") } // Result: right(1)
    /// Either<Int, Int>.right(1).flatMapLeft { _ in .left("zoo") } // Result: right(1)
    ///
    /// Either<Int, Int>.left(1).flatMapLeft { _ in .right("bar") } // Result: right("bar")
    /// Either<Int, Int>.left(1).flatMapLeft { _ in .left("zoo") } // Result: left("zoo")
    /// ```
    func flatMapLeft<Out>(_ transform: (Left) -> Either<Out, Right>) -> Either<Out, Right> {
        switch self {
        case let .left(left):
            return transform(left)

        case let .right(right):
            return .right(right)
        }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` -> `Either<Out, Right>`
    ///
    /// ###### EN:
    /// Transforms to `Either<Out, Right>` by applying the `transform` function if `Either.left`.
    ///
    /// ###### RU:
    /// Трансформирует в `Either<Out, Right>`, применяя функцию `transform` если `Either.left`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1).flatMapLeft { _ in .right("bar") } // Result: right(1)
    /// Either<Int, Int>.right(1).flatMapLeft { _ in .left("zoo") } // Result: right(1)
    ///
    /// Either<Int, Int>.left(1).flatMapLeft { _ in .right("bar") } // Result: right("bar")
    /// Either<Int, Int>.left(1).flatMapLeft { _ in .left("zoo") } // Result: left("zoo")
    /// ```
    func flatMapLeft<Out>(_ transform: (Left) async -> Either<Out, Right>) async -> Either<Out, Right> {
        switch self {
        case let .left(left):
            return await transform(left)

        case let .right(right):
            return .right(right)
        }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` -> `Either<Right, Left>`
    ///
    /// ###### EN:
    /// The value of `Either.right` will be returned to `Either.left`, and the
    /// value of `Either.left` will be returned to `Either.right`.
    ///
    /// ###### RU:
    /// Значение `Either.right` будет возвращено в `Either.left`, а значение
    /// `Either.left` будет возвращено в `Either.right`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1).swap() // Result: left(1)
    /// Either<Int, Int>.left(1).swap() // Result: right(1)
    /// ```
    func swap() -> Either<Right, Left> {
        switch self {
        case let .left(left):
            return .right(left)

        case let .right(right):
            return .left(right)
        }
    }

    /// ###### Signature:
    /// `Either<Left, Either<Left, Right>>` -> `Either<Left, Right>`
    ///
    /// ###### EN:
    /// Reduces nesting for `Either.right`.
    ///
    /// ###### RU:
    /// Уменьшает вложенность для `Either.right`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Either<Int, Int>>.right(.right(1)).flatten() // Result: right(1)
    /// ```
    func flatten<Nested>() -> Either<Left, Nested> where Right == Either<Left, Nested> {
        self.flatMap { $0 }
    }
}
