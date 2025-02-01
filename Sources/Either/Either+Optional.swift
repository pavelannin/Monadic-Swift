//
//  Either+Optional.swift
//  Monadic
//
//  Created by Pavel Annin on 01.02.2025.
//

public extension Either {
    /// ###### EN:
    /// Converts `Optional` to `Either`. Transforming `Optional.some` into `Either.ight`,
    /// and `Optional.none` in `Either.left` using `leftInitial`.
    ///
    /// ###### RU:
    /// Конвертирует `Optional` в `Either`. Трансформируюя `Optional.some` в `Either.right`,
    /// а `Optional.none` в `Either.left` применяя `leftInitial`.
    ///
    /// ###### Example:
    /// ```
    /// Either(optional: .some(1)) { "foo" } // Result: .right(1)
    /// Either(optional: .none) { "foo" } // Result: .left("foo")
    /// ```
    init(optional: Optional<Right>, left leftInitial: () -> Left) {
        self = switch optional {
        case .none:
            .left(leftInitial())

        case let .some(some):
            .right(some)
        }
    }

    /// ###### EN:
    /// Converts `Optional` to `Either`. Transforming `Optional.some` into `Either.ight`,
    /// and `Optional.none` in `Either.left` using `leftInitial`.
    ///
    /// ###### RU:
    /// Конвертирует `Optional` в `Either`. Трансформируюя `Optional.some` в `Either.right`,
    /// а `Optional.none` в `Either.left` применяя `leftInitial`.
    ///
    /// ###### Example:
    /// ```
    /// Either(optional: .some(1)) { "foo" } // Result: .right(1)
    /// Either(optional: .none) { "foo" } // Result: .left("foo")
    /// ```
    init(optional: Optional<Right>, left leftInitial: () async -> Left) async {
        self = switch optional {
        case .none:
            .left(await leftInitial())

        case let .some(some):
            .right(some)
        }
    }
}

public extension Optional {
    /// ###### EN:
    /// Converts `Optional` to `Either`. Transforming `Optional.some` into `Either.right`,
    /// and `Optional.none` in `Either.left` using `noneTransform`.
    ///
    /// ###### RU:
    /// Конвертирует `Optional` в `Either`. Трансформируюя `Optional.some` в `Either.right`,
    /// а `Optional.none` в `Either.left` применяя `noneTransform`.
    ///
    /// ###### Example:
    /// ```
    /// Optional.some(1).asEither { "foo" }  // Result: .right(1)
    /// Optional.none.asEither { "foo" }  // Result: .left("foo")
    /// ```
    func asEither<Left>(none noneTransform: () -> Left) -> Either<Left, Wrapped> {
        .init(optional: self, left: noneTransform)
    }

    /// ###### EN:
    /// Converts `Optional` to `Either`. Transforming `Optional.some` into `Either.right`,
    /// and `Optional.none` in `Either.left` using `noneTransform`.
    ///
    /// ###### RU:
    /// Конвертирует `Optional` в `Either`. Трансформируюя `Optional.some` в `Either.right`,
    /// а `Optional.none` в `Either.left` применяя `noneTransform`.
    ///
    /// ###### Example:
    /// ```
    /// Optional.some(1).asEither { "foo" }  // Result: .right(1)
    /// Optional.none.asEither { "foo" }  // Result: .left("foo")
    /// ```
    func asEither<Left>(none noneTransform: () async -> Left) async -> Either<Left, Wrapped> {
        await .init(optional: self, left: noneTransform)
    }
}
