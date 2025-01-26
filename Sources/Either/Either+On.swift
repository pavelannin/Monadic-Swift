//
//  Either+On.swift
//  Monadic
//
//  Created by Pavel Annin on 25.01.2025.
//

public extension Either {
    /// ###### EN:
    /// Calls the `block` function if `Either.left`.
    ///
    /// ###### RU:
    /// Вызывает функцию `block` если `Either.left`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1).onLeft { _ in print("Hello") }
    /// Either<Int, Int>.left(1).onLeft { _ in print("Hello") } // Log: Hello
    /// ```
    func onLeft(_ body: (Left) -> Void) -> Self {
        if case .left(let left) = self { body(left) }
        return self
    }

    /// ###### EN:
    /// Calls the `block` function if `Either.left`.
    ///
    /// ###### RU:
    /// Вызывает функцию `block` если `Either.left`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1).onLeft { _ in print("Hello") }
    /// Either<Int, Int>.left(1).onLeft { _ in print("Hello") } // Log: Hello
    /// ```
    func onLeft(_ body: (Left) async -> Void) async -> Self {
        if case .left(let left) = self { await body(left) }
        return self
    }

    /// ###### EN:
    /// Calls the `block` function if `Either.right`.
    ///
    /// ###### RU:
    /// Вызывает функцию `block` если `Either.right`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1).onLeft { _ in print("Hello") } // Log: Hello
    /// Either<Int, Int>.left(1).onLeft { _ in print("Hello") }
    /// ```
    func onRight(_ body: (Right) -> Void) -> Self {
        if case .right(let right) = self { body(right) }
        return self
    }

    /// ###### EN:
    /// Calls the `block` function if `Either.right`.
    ///
    /// ###### RU:
    /// Вызывает функцию `block` если `Either.right`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1).onLeft { _ in print("Hello") } // Log: Hello
    /// Either<Int, Int>.left(1).onLeft { _ in print("Hello") }
    /// ```
    func onRight(_ body: (Right) async -> Void) async -> Self {
        if case .right(let right) = self { await body(right) }
        return self
    }
}
