//
//  Result+Map.swift
//  Monadic
//
//  Created by Pavel Annin on 01.02.2025.
//

public extension Result {
    /// ###### Signature:
    /// `Result<Success, Failure>` -> `Result<Out, Failure>`
    ///
    /// ###### EN:
    /// Transforms to `Result<Out, Failure>` by applying the `transform` function if `Result.success`.
    ///
    /// ###### RU:
    /// Трансформирует в `Result<Out, Failure>`, применяя функцию `transform` если `Result.success`.
    ///
    ///###### Example:
    /// ```
    /// .success(1).map { _ in "foo" } // Result: success("foo")
    /// .failure(2).map { _ in "foo" }  // Result: .failure(2)
    /// ```
    func map<Out>(_ transform: (Success) async -> Out) async -> Result<Out, Failure> {
        switch self {
        case let .failure(failure):
            return .failure(failure)

        case let .success(success):
            return .success(await transform(success))
        }
    }

    ///  ###### Signature:
    /// `Result<Success, Failure>` -> `Result<Success, Out>`
    ///
    /// ###### EN:
    /// Transforms to `Result<Success, Out>` by applying the `transform` function if `Result.failure`.
    ///
    /// ###### RU:
    /// Трансформирует в `Result<Success, Out>`, применяя функцию `transform` если `Result.failure`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).mapFailure { "foo" } // Result: .success(1)
    /// .failure(2).mapFailure { "foo" }  // Result: .failure("foo")
    /// ```
    func mapError<Out>(_ transform: (Failure) async -> Out) async -> Result<Success, Out> {
        switch self {
        case let .failure(failure):
            return .failure(await transform(failure))

        case let .success(success):
            return .success(success)
        }
    }

    ///  ###### Signature:
    /// `Result<Success, Failure>` -> `Result<SuccessOut, FailureOut>`
    ///
    /// ###### EN:
    /// Transforms to `Result<SuccessOut, FailureOut>` by applying the `failureTransform` function
    /// if `Result.failure`, or the `successTransform` function if `success`.
    ///
    /// ###### RU:
    /// Трансформирует в `Result<SuccessOut, FailureOut>`, применяя функцию `failureTransform`
    /// если `Result.failure`, или функцию `successTransform` если `success`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).bimap(
    ///     success: { _ in "bar" },
    ///     error: { _ in "foo" }
    /// )  // Result: .success("bar")
    ///
    /// .failure(2).bimap(
    ///     success: { _ in "bar" },
    ///     error: { _ in "foo" }
    /// ) // Result: .failure("foo")
    /// ```
    func bimap<SuccessOut, FailureOut>(
        success successTransform: (Success) -> SuccessOut,
        error failureTransform: (Failure) -> FailureOut
    ) -> Result<SuccessOut, FailureOut> {
        switch self {
        case let .failure(failure):
            return .failure(failureTransform(failure))

        case let .success(success):
            return .success(successTransform(success))
        }
    }

    ///  ###### Signature:
    /// `Result<Success, Failure>` -> `Result<SuccessOut, FailureOut>`
    ///
    /// ###### EN:
    /// Transforms to `Result<SuccessOut, FailureOut>` by applying the `failureTransform` function
    /// if `Result.failure`, or the `successTransform` function if `success`.
    ///
    /// ###### RU:
    /// Трансформирует в `Result<SuccessOut, FailureOut>`, применяя функцию `failureTransform`
    /// если `Result.failure`, или функцию `successTransform` если `success`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).bimap(
    ///     success: { _ in "bar" },
    ///     error: { _ in "foo" }
    /// )  // Result: .success("bar")
    ///
    /// .failure(2).bimap(
    ///     success: { _ in "bar" },
    ///     error: { _ in "foo" }
    /// ) // Result: .failure("foo")
    /// ```
    func bimap<SuccessOut, FailureOut>(
        success successTransform: (Success) async -> SuccessOut,
        error failureTransform: (Failure) async -> FailureOut
    ) async -> Result<SuccessOut, FailureOut> {
        switch self {
        case let .failure(failure):
            return .failure(await failureTransform(failure))

        case let .success(success):
            return .success(await successTransform(success))
        }
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` -> `Out`
    ///
    /// ###### EN:
    /// Transforms to the value `Out`. Applies the `failureTransform` function if `Result.failure`,
    /// or the `successTransform` function if `Result.success`.
    ///
    /// ###### RU:
    /// Трансформирует в значение `Out`. Применяет функцию `failureTransform` если `Result.failure`,
    /// или функцию `successTransform` если `Result.success`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).fold(
    ///     success: { _ in "bar" },
    ///     error: { _ in "foo" }
    /// ) // Result: "bar"
    ///
    /// .failure(2)fold(
    ///     success: { _ in "bar" },
    ///     error: { _ in "foo" }
    /// ) // Result: "foo"
    /// ```
    func fold<Out>(
        failure failureTransform: (Failure) -> Out,
        success successTransform: (Success) -> Out
    ) -> Out {
        switch self {
        case let .failure(failure):
            return failureTransform(failure)

        case let .success(success):
            return successTransform(success)
        }
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` -> `Out`
    ///
    /// ###### EN:
    /// Transforms to the value `Out`. Applies the `failureTransform` function if `Result.failure`,
    /// or the `successTransform` function if `Result.success`.
    ///
    /// ###### RU:
    /// Трансформирует в значение `Out`. Применяет функцию `failureTransform` если `Result.failure`,
    /// или функцию `successTransform` если `Result.success`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).fold(
    ///     success: { _ in "bar" },
    ///     error: { _ in "foo" }
    /// ) // Result: "bar"
    ///
    /// .failure(2)fold(
    ///     success: { _ in "bar" },
    ///     error: { _ in "foo" }
    /// ) // Result: "foo"
    /// ```
    func fold<Out>(
        success successTransform: (Success) async -> Out,
        error failureTransform: (Failure) async -> Out
    ) async -> Out {
        switch self {
        case let .failure(failure):
            return await failureTransform(failure)

        case let .success(success):
            return await successTransform(success)
        }
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` -> `Out`
    ///
    /// ###### EN:
    /// Transforms `Result<Success, Failure>` to the value `Out`. Applies the `transform` function
    /// if `Result.failure`, otherwise returns the value `initial`.
    ///
    /// ###### RU:
    /// Трансформирует в `Result<Success, Failure>` в значение `Out`. Применяет функцию `transform`
    /// если `Result.failure`, иначе возвращает значение `initial`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1)
    ///     .foldError(initial: "foo") { _ in "bar" }) // Result: "foo"
    ///
    /// .failure(2)
    ///     .foldError(initial: "foo") { _ in "bar" }) // Result: "bar"
    /// ```
    func foldError<Out>(initial: Out, transform: (Failure) -> Out) -> Out {
        if case .failure(let failure) = self { return transform(failure) }
        return initial
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` -> `Out`
    ///
    /// ###### EN:
    /// Transforms `Result<Success, Failure>` to the value `Out`. Applies the `transform` function
    /// if `Result.failure`, otherwise returns the value `initial`.
    ///
    /// ###### RU:
    /// Трансформирует в `Result<Success, Failure>` в значение `Out`. Применяет функцию `transform`
    /// если `Result.failure`, иначе возвращает значение `initial`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1)
    ///     .foldError(initial: "foo") { _ in "bar" }) // Result: "foo"
    ///
    /// .failure(2)
    ///     .foldError(initial: "foo") { _ in "bar" }) // Result: "bar"
    /// ```
    func foldError<Out>(initial: Out, transform: (Failure) async -> Out) async -> Out {
        if case .failure(let failure) = self { return await transform(failure) }
        return initial
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` -> `Out`
    ///
    /// ###### EN:
    /// Transforms `Result<Success, Failure>` to the value `Out`. Applies the `transform` function
    /// if `Result.success`, otherwise returns the value `initial`.
    ///
    /// ###### RU:
    /// Трансформирует в `Result<Success, Failure>` в значение `Out`. Применяет функцию `transform`
    /// если `Result.success`, иначе возвращает значение `initial`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1)
    ///     .foldSuccess(initial: "foo") { _ in "bar" } // Result: "bar"
    ///
    /// .failure(2)
    ///     .foldSuccess(initial: "foo") { _ in "bar" } // Result: "foo"
    /// ```
    func foldSuccess<Out>(initial: Out, transform: (Success) -> Out) -> Out {
        if case .success(let success) = self { return transform(success) }
        return initial
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` -> `Out`
    ///
    /// ###### EN:
    /// Transforms `Result<Success, Failure>` to the value `Out`. Applies the `transform` function
    /// if `Result.success`, otherwise returns the value `initial`.
    ///
    /// ###### RU:
    /// Трансформирует в `Result<Success, Failure>` в значение `Out`. Применяет функцию `transform`
    /// если `Result.success`, иначе возвращает значение `initial`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1)
    ///     .foldSuccess(initial: "foo") { _ in "bar" } // Result: "bar"
    ///
    /// .failure(2)
    ///     .foldSuccess(initial: "foo") { _ in "bar" } // Result: "foo"
    /// ```
    func foldSuccess<Out>(initial: Out, transform: (Success) async -> Out) async -> Out {
        if case .success(let success) = self { return await transform(success) }
        return initial
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` -> `Result<Out, Failure>`
    ///
    /// ###### EN:
    /// Transforms to `Result<Out, Failure>` by applying the `transform` function if `Result.success`.
    ///
    /// ###### RU:
    /// Трансформирует в `Result<Out, Failure>`, применяя функцию `transform` если `Result.success`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).flatMap { _ in .success("bar") } // Result: success("bar")
    /// .success(1).flatMap { _ in .failure(3) } // Result: failure(3)
    ///
    /// .failure(2).flatMap { _ in  .success("bar") } // Result: failure(2)
    /// .failure(2).flatMap { _ in  .failure(3) } // Result: failure(2)
    /// ```
    func flatMap<Out>(_ transform: (Success) async -> Result<Out, Failure>) async -> Result<Out, Failure> {
        switch self {
        case let .failure(failure):
            return .failure(failure)

        case let .success(success):
            return await transform(success)
        }
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` -> `Result<Success, Out>`
    ///
    /// ###### EN:
    /// Transforms to `Result<Success, Out>` by applying the `transform` function if `Result.failure`.
    ///
    /// ###### RU:
    /// Трансформирует в `Result<Success, Out>`, применяя функцию `transform` если `Result.failure`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).flatMapError { _ in .success(3) } // Result: success(1)
    /// .success(1).flatMapError { _ in .failure("zoo") } // Result: success(1)
    ///
    /// .failure(2).flatMapError { _ in .success(3) } // Result: success(3)
    /// .failure(2).flatMapError { _ in .failure("zoo") } // Result: failure("zoo")
    /// ```
    func flatMapError<Out>(_ transform: (Failure) -> Result<Success, Out>) -> Result<Success, Out> {
        switch self {
        case let .failure(failure):
            return transform(failure)

        case let .success(success):
            return .success(success)
        }
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` -> `Result<Success, Out>`
    ///
    /// ###### EN:
    /// Transforms to `Result<Success, Out>` by applying the `transform` function if `Result.failure`.
    ///
    /// ###### RU:
    /// Трансформирует в `Result<Success, Out>`, применяя функцию `transform` если `Result.failure`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).flatMapError { _ in .success(3) } // Result: success(1)
    /// .success(1).flatMapError { _ in .failure("zoo") } // Result: success(1)
    ///
    /// .failure(2).flatMapError { _ in .success(3) } // Result: success(3)
    /// .failure(2).flatMapError { _ in .failure("zoo") } // Result: failure("zoo")
    /// ```
    func flatMapError<Out>(_ transform: (Failure) async -> Result<Success, Out>) async -> Result<Success, Out> {
        switch self {
        case let .failure(failure):
            return await transform(failure)

        case let .success(success):
            return .success(success)
        }
    }

    /// ###### Signature:
    /// `Result<Result<Success, Failure>, Failure>` -> `Result<Success, Failure>`
    ///
    /// ###### EN:
    /// Reduces nesting for `Result.success`.
    ///
    /// ###### RU:
    /// Уменьшает вложенность для `Result.success`.
    ///
    /// ###### Example:
    /// ```
    /// .success(.success(1)).flatten() // Result: success(1)
    /// .failure(2).flatten() // Result: failure(2)
    /// ```
    func flatten<Nested>() -> Result<Nested, Failure> where Success == Result<Nested, Failure> {
        self.flatMap { $0 }
    }

    /// ###### Signature:
    /// `Result<Result<Success, Failure>, Failure>` -> `Result<Success, Failure>`
    ///
    /// ###### EN:
    /// Reduces nesting for `Result.success`.
    ///
    /// ###### RU:
    /// Уменьшает вложенность для `Result.success`.
    ///
    /// ###### Example:
    /// ```
    /// .success(.success(1)).flatten() // Result: success(1)
    /// .failure(2).flatten() // Result: failure(2)
    /// ```
    func flatten<Nested>() async -> Result<Nested, Failure> where Success == Result<Nested, Failure> {
        await self.flatMap { $0 }
    }
}
