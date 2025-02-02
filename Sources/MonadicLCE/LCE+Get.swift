//
//  LCE+Get.swift
//  Monadic
//
//  Created by Pavel Annin on 02.02.2025.
//

public extension LCE {
    /// ###### EN:
    /// Returns `true` if it is `LCE.loading`, or `false` otherwise.
    ///
    /// ###### RU:
    /// Возвращает значение `true`, если `LCE.Loading`, в противном случае `false`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).isLoading // Result: true
    /// .content(2).isLoading // Result: false
    /// .error(3).isLoading // Result: false
    /// ```
    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }

    /// ###### EN:
    /// Returns `true` if it is `LCE.content`, or `false` otherwise.
    ///
    /// ###### RU:
    /// Возвращает значение `true`, если `LCE.content`, в противном случае `false`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).isContent // Result: false
    /// .content(2).isContent // Result: true
    /// .error(3).isContent // Result: false
    /// ```
    var isContent: Bool {
        if case .content = self { return true }
        return false
    }

    /// ###### EN:
    /// Returns `true` if it is `LCE.error`, or `false` otherwise.
    ///
    /// ###### RU:
    /// Возвращает значение `true`, если `LCE.error`, в противном случае `false`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).isError // Result: false
    /// .content(2).isError // Result: false
    /// .error(3).isError // Result: true
    /// ```
    var isError: Bool {
        if case .error = self { return true }
        return false
    }

    /// ###### EN:
    /// Returns the value `true` if `LCE.content` or `LCE.error`, otherwise `false`.
    ///
    /// ###### RU:
    /// Возвращает значение `true`, если `LCE.content` или `LCE.error`, в противном случае `false`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).isComplete // Result: false
    /// .content(2).isComplete // Result: true
    /// .error(3).isComplete // Result: true
    /// ```
    var isComplete: Bool {
        if self.isContent || self.isLoading { return true }
        return false
    }

    /// ###### EN:
    /// Returns value if it is `LCE.loading`, or `nil` otherwise.
    ///
    /// ###### RU:
    /// Возвращает значение, если `LCE.loading`, в противном случае `nil`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).loadingOrNil() // Result: 1
    /// .content(2).loadingOrNil() // Result: nil
    /// .error(3).loadingOrNil() // Result: nil
    /// ```
    func loadingOrNil() -> Loading? {
        if case .loading(let loading) = self { return loading }
        return nil
    }

    /// ###### EN:
    /// Returns value if it is `LCE.content`, or `nil` otherwise.
    ///
    /// ###### RU:
    /// Возвращает значение  если `LCE.content`, в противном случае `nil`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).contentOrNil() // Result: nil
    /// .content(2).contentOrNil() // Result: 2
    /// .error(3).contentOrNil() // Result: nil
    /// ```
    func contentOrNil() -> Content? {
        if case .content(let content) = self { return content }
        return nil
    }

    /// ###### EN:
    /// Returns value if it is `LCE.error`, or `nil` otherwise.
    ///
    /// ###### RU:
    /// Возвращает значение  если `LCE.error`, в противном случае `nil`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).errorOrNil() // Result: nil
    /// .content(2).errorOrNil() // Result: nil
    /// .error(3).errorOrNil() // Result: 3
    /// ```
    func errorOrNil() -> Failure? {
        if case .error(let error) = self { return error }
        return nil
    }
}
