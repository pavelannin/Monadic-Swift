//
//  Result+Get.swift
//  Monadic
//
//  Created by Pavel Annin on 01.02.2025.
//

public extension Result {
    /// ###### EN:
    /// Returns `true` if it is `Result.failure`, or `false` otherwise.
    ///
    ///###### RU:
    ///Возвращает значение `true`, если `Result.failure`, в противном случае `false`.
    ///
    ///###### Example:
    /// ```
    /// .success(1).isError // Result: false
    /// .failure(2).isError // Result: true
    /// ```
    var isError: Bool {
        if case .failure = self { return true }
        return false
    }

    /// ###### EN:
    /// Returns `true` if it is `Result.success`, or `false` otherwise.
    ///
    /// ###### RU:
    /// Возвращает значение `true`, если `Result.success`, в противном случае `false`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).isSuccess // Result: true
    /// .failure(2).isSuccess // Result: false
    /// ```
    var isSuccess: Bool {
        if case .success = self { return true }
        return false
    }

    /// ###### EN:
    /// Returns `value` if it is `Result.failure`, or `nil` otherwise.
    ///
    /// ###### RU:
    /// Возвращает значение `value`, если `Result.failure`, в противном случае `nil`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).errorOrNil() // Result: nil
    /// .failure(2).errorOrNil() // Result: 2
    /// ```
    func errorOrNil() -> Failure? {
        if case .failure(let value) = self { return value }
        return nil
    }

    /// ###### EN:
    /// Returns `value` if it is `Result.success`, or `nil` otherwise.
    ///
    /// ###### RU:
    /// Возвращает значение `value`, если `Result.success`, в противном случае `nil`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).successOrNil() // Result: 1
    /// .failure(2).successOrNil() // Result: nil
    /// ```
    func successOrNil() -> Success? {
        if case .success(let value) = self { return value }
        return nil
    }

    /// ###### EN:
    /// Returns `value` if it is `Result.failure`, or `default` otherwise.
    ///
    /// ###### RU:
    /// Возвращает значение `value`, если `Result.failure`, в противном случае `default`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).errorOrDefault(3) // Result: 3
    /// .failure(2).errorOrDefault(3) // Result: 2
    /// ```
    func errorOrDefault(default value: Failure) -> Failure {
        if case .failure(let failure) = self { return failure }
        return value
    }

    /// ###### EN:
    /// Returns `value` if it is `Result.success`, or `default` otherwise.
    ///
    /// ###### RU:
    /// Возвращает значение `value`, если `Result.success`, в противном случае `default`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).successOrDefault(3) // Result: 1
    /// .failure(2).successOrDefault(3) // Result: 3
    /// ```
    func successOrDefault(default value: Success) -> Success {
        if case .success(let success) = self { return success }
        return value
    }

    /// ###### EN:
    /// Returns the value if `Result.failure`, otherwise applies the `transform` function
    ///
    /// ###### RU:
    /// Возвращает значение, если `Result.failure`, в противном случае применяет функцию `transform`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).errorOrElse { _ in 3} // Result: 3
    /// .failure(2).errorOrElse { _ in 3 } // Result: 2
    /// ```
    func errorOrElse(_ transform: (Success) -> Failure) -> Failure {
        switch self {
        case let .failure(failure):
            return failure

        case let .success(success):
            return transform(success)
        }
    }

    /// ###### EN:
    /// Returns the value if `Result.failure`, otherwise applies the `transform` function
    ///
    /// ###### RU:
    /// Возвращает значение, если `Result.failure`, в противном случае применяет функцию `transform`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1).errorOrElse { _ in 3 } // Result: 3
    /// .failure(2).errorOrElse { _ in 3 } // Result: 2
    /// ```
    func errorOrElse(_ transform: (Success) async -> Failure) async -> Failure {
        switch self {
        case let .failure(failure):
            return failure

        case let .success(success):
            return await transform(success)
        }
    }


    /// EN:
    /// Returns the value if `Result.success`, otherwise applies the `transform` function
    ///
    /// ###### RU:
    /// Возвращает значение, если `Result.success`, в противном случае применяет функцию `transform`.
    ///
    ///###### Example:
    /// ```
    /// .success(1).successOrElse { _ in 3 } // Result: 1
    /// .failure(2).successOrElse { _ in 3 } // Result: 3
    /// ```
    func successOrElse(_ transform: (Failure) -> Success) -> Success {
        switch self {
        case let .failure(failure):
            return transform(failure)

        case let .success(success):
            return success
        }
    }

    /// EN:
    /// Returns the value if `Result.success`, otherwise applies the `transform` function
    ///
    /// ###### RU:
    /// Возвращает значение, если `Result.success`, в противном случае применяет функцию `transform`.
    ///
    ///###### Example:
    /// ```
    /// .success(1).successOrElse { _ in 3 } // Result: 1
    /// .failure(2).successOrElse { _ in 3 } // Result: 3
    /// ```
    func successOrElse(_ transform: (Failure) async -> Success) async -> Success {
        switch self {
        case let .failure(failure):
            return await transform(failure)

        case let .success(success):
            return success
        }
    }
}
