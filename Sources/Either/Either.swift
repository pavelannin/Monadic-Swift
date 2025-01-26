//
//  Either.swift
//  Monadic
//
//  Created by Pavel Annin on 25.01.2025.
//

/// ###### EN:
/// The `Either` monad is a functional programming construct used to handle alternative results or errors.
/// It is a pair of values `Left` (for incorrect or alternative values) and `Right` (for correct ones).
/// The `Either` monad allows you to handle both variants in the same type.
/// This makes its application in error handling very useful.
///
/// ###### RU:
/// Монада `Either` - это функциональная конструкция, используемая для обработки альтернативных результатов или ошибок.
/// Собержит пару значений `Left` (для неправильных или альтернативных значений) и `Right` (для правильных значений).
/// Монада `Either` позволяет обрабатывать оба варианта в одном типе что делает применение монады удобным.
///
/// ###### Example:
/// ```
/// let right: Either<Void, Void> = .right(())
/// let left: Either<Void, Void> = .left(())
/// ```
@frozen
public enum Either<Left, Right> {
    /// ###### EN:
    /// The left value (for incorrect or alternative values) of the monad is `Either`.
    ///
    ///###### RU:
    ///Левое значение (для неправильных или альтернативных значений) монады `Either`.
    case left(Left)

    /// ###### EN:
    /// The right value (for correct ones) of the monad is `Either`.
    ///
    /// ###### RU:
    /// Правое значение (для правильных значений) монады `Either`.
    case right(Right)
}
