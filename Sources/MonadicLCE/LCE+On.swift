//
//  LCE+On.swift
//  Monadic
//
//  Created by Pavel Annin on 02.02.2025.
//

public extension LCE {
    /// ###### EN:
    /// Calls the `body` function if `LCE.loading`.
    ///
    /// ###### RU:
    /// Вызывает функцию `body` если `LCE.loading`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).onLoading { value in print(value) } // Log: 1
    /// .content(2).onLoading { value in print(value) } // Empty
    /// .error(3).onLoading { value in print(value) } // Empty
    /// ```
    func onLoading(_ body: (Loading) -> Void) -> Self {
        if case .loading(let loading) = self { body(loading) }
        return self
    }

    /// ###### EN:
    /// Calls the `body` function if `LCE.loading`.
    ///
    /// ###### RU:
    /// Вызывает функцию `body` если `LCE.loading`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).onLoading { value in print(value) } // Log: 1
    /// .content(2).onLoading { value in print(value) } // Empty
    /// .error(3).onLoading { value in print(value) } // Empty
    /// ```
    func onLoading(_ body: (Loading) async -> Void) async -> Self {
        if case .loading(let loading) = self { await body(loading) }
        return self
    }

    /// ###### EN:
    /// Calls the `body` function if `LCE.content`.
    ///
    /// ###### RU:
    /// Вызывает функцию `body` если `LCE.content`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).onLoading { value in print(value) } // Empty
    /// .content(2).onLoading { value in print(value) } // Log: 2
    /// .error(3).onLoading { value in print(value) } // Empty
    /// ```
    func onContent(_ body: (Content) -> Void) -> Self {
        if case .content(let content) = self { body(content) }
        return self
    }

    /// ###### EN:
    /// Calls the `body` function if `LCE.content`.
    ///
    /// ###### RU:
    /// Вызывает функцию `body` если `LCE.content`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).onLoading { value in print(value) } // Empty
    /// .content(2).onLoading { value in print(value) } // Log: 2
    /// .error(3).onLoading { value in print(value) } // Empty
    /// ```
    func onContent(_ body: (Content) async -> Void) async -> Self {
        if case .content(let content) = self { await body(content) }
        return self
    }

    /// ###### EN:
    /// Calls the `body` function if `LCE.error`.
    ///
    /// ###### RU:
    /// Вызывает функцию `body` если `LCE.error`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).onLoading { value in print(value) } // Empty
    /// .content(2).onLoading { value in print(value) } // Empty
    /// .error(3).onLoading { value in print(value) } // Log: 3
    /// ```
    func onError(_ body: (Failure) -> Void) -> Self {
        if case .error(let error) = self { body(error) }
        return self
    }

    /// ###### EN:
    /// Calls the `body` function if `LCE.error`.
    ///
    /// ###### RU:
    /// Вызывает функцию `body` если `LCE.error`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).onLoading { value in print(value) } // Empty
    /// .content(2).onLoading { value in print(value) } // Empty
    /// .error(3).onLoading { value in print(value) } // Log: 3
    /// ```
    func onError(_ body: (Failure) async -> Void) async -> Self {
        if case .error(let error) = self { await body(error) }
        return self
    }
}
