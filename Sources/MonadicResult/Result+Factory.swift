//
//  Result+Factory.swift
//  Monadic
//
//  Created by Pavel Annin on 01.02.2025.
//

public extension Result {
    /// ###### EN:
    /// Wraps the execution of `body` in a 'do-catch'. `Result.failure` is returned if `body` returned an exception.
    ///
    /// ###### RU:
    /// Оборачивает выполнение `body` в `do-catch`. Возвращается `Result.failure` если `body` вернул исключение.
    init(catching body: () async throws(Failure) -> Success) async {
        do {
            self = .success(try await body())
        } catch let error {
            self = .failure(error)
        }
    }

    /// ###### EN:
    /// Converts the transformation function `transform` into a `Result` structure that returns a polymorphic
    /// function that can be applied to all values of `Result`.
    ///
    /// ###### RU:
    /// Возвращает полиморфную функцию преобразующую функцию `transform` в структуру `Result`.
    static func lift<Out>(
        _ transform: @escaping (Success) -> Out
    ) -> (Self) -> Result<Out, Failure> {
        { result in result.map(transform) }
    }

    /// ###### EN:
    /// Converts the transformation function `transform` into a `Result` structure that returns a polymorphic
    /// function that can be applied to all values of `Result`.
    ///
    /// ###### RU:
    /// Возвращает полиморфную функцию преобразующую функцию `transform` в структуру `Result`.
    static func lift<Out>(
        _ transform: @escaping (Success) async -> Out
    ) -> (Self) async -> Result<Out, Failure> {
        { result in await result.map(transform) }
    }

    /// ###### EN:
    /// Converts the transformation function `failureTransform` and `successTransform` into a `Result` structure that returns a polymorphic
    /// function that can be applied to all values of `Result`.
    ///
    /// ###### RU:
    /// Возвращает полиморфную функцию преобразующую функцию `failureTransform` и `successTransform` в структуру `Result`.
    static func lift<SuccessOut, FailureOut>(
        success successTransform: @escaping (Success) -> SuccessOut,
        error failureTransform: @escaping (Failure) -> FailureOut
    ) -> (Self) -> Result<SuccessOut, FailureOut> {
        { result in result.bimap(success: successTransform, error: failureTransform) }
    }

    /// ###### EN:
    /// Converts the transformation function `failureTransform` and `successTransform` into a `Result` structure that returns a polymorphic
    /// function that can be applied to all values of `Result`.
    ///
    /// ###### RU:
    /// Возвращает полиморфную функцию преобразующую функцию `failureTransform` и `successTransform` в структуру `Result`.
    static func lift<SuccessOut, FailureOut>(
        success successTransform: @escaping (Success) async -> SuccessOut,
        error failureTransform: @escaping (Failure) async -> FailureOut
    ) -> (Self) async -> Result<SuccessOut, FailureOut> {
        { result in await result.bimap(success: successTransform, error: failureTransform) }
    }
}
