//
//  Either+Factory.swift
//  Monadic
//
//  Created by Pavel Annin on 25.01.2025.
//

public extension Either {
    /// ###### EN:
    /// Wraps the execution of `body` in a 'do-catch'. `Either.left` is returned if `body` returned an exception.
    ///
    ///###### RU:
    ///Оборачивает выполнение `body` в `do-catch`. Возвращается `Either.left` если `body` вернул исключение.
    init(catching body: () throws(Left) -> Right) {
        do {
            self = .right(try body())
        } catch let error {
            self = .left(error)
        }
    }

    /// ###### EN:
    /// Wraps the execution of `body` in a 'do-catch'. `Either.left` is returned if `body` returned an exception.
    ///
    ///###### RU:
    ///Оборачивает выполнение `body` в `do-catch`. Возвращается `Either.left` если `body` вернул исключение.
    init(catching body: () async throws(Left) -> Right) async {
        do {
            self = .right(try await body())
        } catch let error {
            self = .left(error)
        }
    }

    /// ###### EN:
    /// Converts the transformation function `transform` into a `Either` structure that returns a polymorphic
    ///function that can be applied to all values of `Either`.
    ///
    ///###### RU:
    ///Возвращает полиморфную функцию преобразующую функцию `transform` в структуру `Either`.
    static func lift<Out>(
        _ transform: @escaping (Right) -> Out
    ) -> (Self) -> Either<Left, Out> {
        { either in either.map(transform) }
    }

    /// ###### EN:
    /// Converts the transformation function `transform` into a `Either` structure that returns a polymorphic
    ///function that can be applied to all values of `Either`.
    ///
    ///###### RU:
    ///Возвращает полиморфную функцию преобразующую функцию `transform` в структуру `Either`.
    static func lift<Out>(
        _ transform: @escaping (Right) async -> Out
    ) -> (Self) async -> Either<Left, Out> {
        { either in await either.map(transform) }
    }

    /// ###### EN:
    /// Converts the transformation function `leftTransform` and `rightTransform` into a `Either` structure that returns a polymorphic
    /// function that can be applied to all values of `Either`.
    ///
    /// ###### RU:
    /// Возвращает полиморфную функцию преобразующую функцию `leftTransform` и `rightTransform` в структуру `Either`.
    static func lift<LeftOut, RightOut>(
        left leftTransform: @escaping (Left) -> LeftOut,
        right rightTransform: @escaping (Right) -> RightOut
    ) -> (Self) -> Either<LeftOut, RightOut> {
        { either in either.bimap(left: leftTransform, right: rightTransform) }
    }

    /// ###### EN:
    /// Converts the transformation function `leftTransform` and `rightTransform` into a `Either` structure that returns a polymorphic
    /// function that can be applied to all values of `Either`.
    ///
    /// ###### RU:
    /// Возвращает полиморфную функцию преобразующую функцию `leftTransform` и `rightTransform` в структуру `Either`.
    static func lift<LeftOut, RightOut>(
        left leftTransform: @escaping (Left) async -> LeftOut,
        right rightTransform: @escaping (Right) async -> RightOut
    ) -> (Self) async -> Either<LeftOut, RightOut> {
        { either in await either.bimap(left: leftTransform, right: rightTransform) }
    }
}
