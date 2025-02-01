//
//  Either+Result.swift
//  Monadic
//
//  Created by Pavel Annin on 01.02.2025.
//

public extension Either where Left : Error {
    /// ###### EN:
    /// Convert `Result` to `Either`. Transcription of `Result.success` to `Either.right`, `Result.failure` to `Either.left`
    ///
    /// ###### RU:
    /// Конвертирует `Result` в `Either`. Трансформируюя `Result.success` в `Either.right`, а `Result.failure`  в `Either.left`
    ///
    /// ###### Example:
    /// ```
    /// Either(result: .success(1)) // Result: .right(1)
    /// Either(result: .failure(.error)) // Result: .left(.error)
    /// ```
    init(result: Result<Right, Left>) {
        self = switch result {
        case let .success(success):
            .right(success)

        case let .failure(failure):
            .left(failure)
        }
    }

    /// ###### EN:
    /// Convert `Either` to `Result`. Transcription of `Either.right` to `Result.success`, `Either.left` to `Result.failure`
    ///
    /// ###### RU:
    /// Конвертирует `Either` в `Result`. Трансформируюя `Either.right` в `Result.success`, а `Either.left`  в `Result.failure`
    ///
    /// ###### Example:
    /// ```
    /// Either.left(.error).asResult() // Result: .failure(.error)
    /// Either.right(1).asResult() // Result: .success(1)
    /// ```
    func asResult() -> Result<Right, Left> {
        .init(either: self)
    }
}

public extension Result {
    /// ###### EN:
    /// Convert `Either` to `Result`. Transcription of `Either.right` to `Result.success`, `Either.left` to `Result.failure`
    ///
    /// ###### RU:
    /// Конвертирует `Either` в `Result`. Трансформируюя `Either.right` в `Result.success`, а `Either.left`  в `Result.failure`
    ///
    /// ###### Example:
    /// ```
    /// Result(either: .left(.error)) // Result: .failure(.error)
    /// Result(either: .right(1)) // Result: .success(1)
    /// ```
    init(either: Either<Failure, Success>) {
        self = switch either {
        case let .left(left):
            .failure(left)

        case let .right(right):
            .success(right)
        }
    }

    /// ###### EN:
    /// Convert `Result` to `Either`. Transcription of `Result.success` to `Either.right`, `Result.failure` to `Either.left`
    ///
    /// ###### RU:
    /// Конвертирует `Result` в `Either`. Трансформируюя `Result.success` в `Either.right`, а `Result.failure`  в `Either.left`
    ///
    /// ###### Example:
    /// ```
    /// Result.success(1).asEither() // Result: .right(1)
    /// Result.failure(.error).asEither() // Result: .left(.error)
    /// ```
    func asEither() -> Either<Failure, Success> {
        .init(result: self)
    }
}
