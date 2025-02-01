//
//  Result+On.swift
//  Monadic
//
//  Created by Pavel Annin on 01.02.2025.
//

public extension Result {
    /// ###### EN:
    /// Calls the `block` function if `Result.failure`.
    ///
    /// ###### RU:
    /// Вызывает функцию `body` если `Result.failure`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).onError { _ in print("Hello") }
    /// .failure(2).onError { _ in print("Hello") } // Log: Hello
    /// ```
    func onError(_ body: (Failure) -> Void) -> Self {
        if case .failure(let failure) = self { body(failure) }
        return self
    }

    /// ###### EN:
    /// Calls the `block` function if `Result.failure`.
    ///
    /// ###### RU:
    /// Вызывает функцию `body` если `Result.failure`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).onError { _ in print("Hello") }
    /// .failure(2).onError { _ in print("Hello") } // Log: Hello
    /// ```
    func onError(_ body: (Failure) async -> Void) async -> Self {
        if case .failure(let failure) = self { await body(failure) }
        return self
    }

    /// ###### EN:
    /// Calls the `block` function if `Result.success`.
    ///
    /// ###### RU:
    /// Вызывает функцию `body` если `Result.success`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).onFailure { _ in print("Hello") } // Log: Hello
    /// .failure(2).onFailure { _ in print("Hello") }
    /// ```
    func onSuccess(_ body: (Success) -> Void) -> Self {
        if case .success(let success) = self { body(success) }
        return self
    }

    /// ###### EN:
    /// Calls the `block` function if `Result.success`.
    ///
    /// ###### RU:
    /// Вызывает функцию `body` если `Result.success`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).onFailure { _ in print("Hello") } // Log: Hello
    /// .failure(2).onFailure { _ in print("Hello") }
    /// ```
    func onSuccess(_ body: (Success) async -> Void) async -> Self {
        if case .success(let success) = self { await body(success) }
        return self
    }
}
