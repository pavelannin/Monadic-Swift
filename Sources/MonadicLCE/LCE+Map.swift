//
//  LCE+Map.swift
//  Monadic
//
//  Created by Pavel Annin on 02.02.2025.
//

public extension LCE {
    /// ###### Signature:
    /// `LCE<Loading, Content, Failure>` -> `LCE<Out, Content, Failure>`
    ///
    /// ###### EN:
    /// Transforms to `LCE<Out, Content, Failure>` by applying the `transform` function if `LCE.loading`.
    ///
    /// ###### RU:
    /// Трансформирует в `LCE<Out, Content, Failure>`, применяя функцию `transform` если `LCE.loading`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).mapLoading { _ in "foo" } // Result: .loading("foo")
    /// .content(2).mapLoading { _ in "foo" } // Result: .content(2)
    /// .error(3).mapLoading { _ in "foo" } // Result: .error(3)
    /// ```
    func mapLoading<Out>(_ transform: (Loading) -> Out) -> LCE<Out, Content, Failure> {
        switch self {
        case let .loading(loading):
            .loading(transform(loading))

        case let .content(content):
            .content(content)

        case let .error(error):
            .error(error)
        }
    }

    /// ###### Signature:
    /// `LCE<Loading, Content, Failure>` -> `LCE<Out, Content, Failure>`
    ///
    /// ###### EN:
    /// Transforms to `LCE<Out, Content, Failure>` by applying the `transform` function if `LCE.loading`.
    ///
    /// ###### RU:
    /// Трансформирует в `LCE<Out, Content, Failure>`, применяя функцию `transform` если `LCE.loading`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).mapLoading { _ in "foo" } // Result: .loading("foo")
    /// .content(2).mapLoading { _ in "foo" } // Result: .content(2)
    /// .error(3).mapLoading { _ in "foo" } // Result: .error(3)
    /// ```
    func mapLoading<Out>(_ transform: (Loading) async -> Out) async -> LCE<Out, Content, Failure> {
        switch self {
        case let .loading(loading):
            .loading(await transform(loading))

        case let .content(content):
            .content(content)

        case let .error(error):
            .error(error)
        }
    }

    /// ###### Signature:
    /// `LCE<Loading, Content, Failure>` -> `LCE<Loading, Out, Failure>`
    ///
    /// ###### EN:
    /// Transforms to `LCE<Loading, Out, Failure>` by applying the `transform` function if `LCE.content`.
    ///
    /// ###### RU:
    /// Трансформирует в `LCE<Loading, Out, Failure>`, применяя функцию `transform` если `LCE.content`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).mapContent { _ in "foo" } // Result: .loading(1)
    /// .content(2).mapContent { _ in "foo" } // Result: .content("foo")
    /// .error(3).mapContent { _ in "foo" } // Result: .error(3)
    /// ```
    func mapContent<Out>(_ transform: (Content) -> Out) -> LCE<Loading, Out, Failure> {
        switch self {
        case let .content(content):
            .content(transform(content))

        case let .loading(loading):
            .loading(loading)

        case let .error(error):
            .error(error)
        }
    }

    /// ###### Signature:
    /// `LCE<Loading, Content, Failure>` -> `LCE<Loading, Out, Failure>`
    ///
    /// ###### EN:
    /// Transforms to `LCE<Loading, Out, Failure>` by applying the `transform` function if `LCE.content`.
    ///
    /// ###### RU:
    /// Трансформирует в `LCE<Loading, Out, Failure>`, применяя функцию `transform` если `LCE.content`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).mapContent { _ in "foo" } // Result: .loading(1)
    /// .content(2).mapContent { _ in "foo" } // Result: .content("foo")
    /// .error(3).mapContent { _ in "foo" } // Result: .error(3)
    /// ```
    func mapContent<Out>(_ transform: (Content) async -> Out) async -> LCE<Loading, Out, Failure> {
        switch self {
        case let .content(content):
            .content(await transform(content))

        case let .loading(loading):
            .loading(loading)

        case let .error(error):
            .error(error)
        }
    }

    /// ###### Signature:
    /// `LCE<Loading, Content, Failure>` -> `LCE<Loading, Content, Out>`
    ///
    /// ###### EN:
    /// Transforms to `LCE<Loading, Content, Out>` by applying the `transform` function if `LCE.error`.
    ///
    /// ###### RU:
    /// Трансформирует в `LCE<Loading, Content, Out>`, применяя функцию `transform` если `LCE.error`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).mapError { _ in "foo" } // Result: .loading(1)
    /// .content(2).mapError { _ in "foo" } // Result: .content(2)
    /// .error(3).mapError { _ in "foo" } // Result: .error("foo")
    /// ```
    func mapError<Out>(_ transform: (Failure) -> Out) -> LCE<Loading, Content, Out> {
        switch self {
        case let .error(error):
            .error(transform(error))

        case let .loading(loading):
            .loading(loading)

        case let .content(content):
            .content(content)
        }
    }

    /// ###### Signature:
    /// `LCE<Loading, Content, Failure>` -> `LCE<Loading, Content, Out>`
    ///
    /// ###### EN:
    /// Transforms to `LCE<Loading, Content, Out>` by applying the `transform` function if `LCE.error`.
    ///
    /// ###### RU:
    /// Трансформирует в `LCE<Loading, Content, Out>`, применяя функцию `transform` если `LCE.error`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).mapError { _ in "foo" } // Result: .loading(1)
    /// .content(2).mapError { _ in "foo" } // Result: .content(2)
    /// .error(3).mapError { _ in "foo" } // Result: .error("foo")
    /// ```
    func mapError<Out>(_ transform: (Failure) async -> Out) async -> LCE<Loading, Content, Out> {
        switch self {
        case let .error(error):
            .error(await transform(error))

        case let .loading(loading):
            .loading(loading)

        case let .content(content):
            .content(content)
        }
    }

    ///  ###### Signature:
    /// `LCE<Loading, Content, Failure>` -> `LCE<LoadingOut, ContentOut, FailureOut>`
    ///
    /// ###### EN:
    /// Transforms to `LCE<LoadingOut, ContentOut, FailureOut>` by applying the `loading` function if `LCE.loading`,
    /// the `content` function if `LCE.content`, or the `error` function if `LCE.error`.
    ///
    /// ###### RU:
    /// Трансформирует в `LCE<LoadingOut, ContentOut, FailureOut>`, применяя функцию `loading` если `LCE.loading`,
    /// функцию `content` если `LCE.content`, или функцию `error` если `LCE.error`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).map(
    ///     loading: { _ in "foo" },
    ///     content: { _ in "bar" },
    ///     error: { _ in "zoo" }
    /// ) // Result: .loading("foo")
    ///
    /// .content(2).map(
    ///     loading: { _ in "foo" },
    ///     content: { _ in "bar" },
    ///     error: { _ in "zoo" }
    /// ) // Result: .content("bar")
    ///
    /// .error(2).map(
    ///     loading: { _ in "foo" },
    ///     content: { _ in "bar" },
    ///     error: { _ in "zoo" }
    /// ) // Result: .error("zoo")
    /// ```
    func map<LoadingOut, ContentOut, FailureOut>(
        loading loadingTransform: (Loading) -> LoadingOut,
        content contentTransform: (Content) -> ContentOut,
        error errorTransform: (Failure) -> FailureOut
    ) -> LCE<LoadingOut, ContentOut, FailureOut> {
        return self
            .mapLoading(loadingTransform)
            .mapContent(contentTransform)
            .mapError(errorTransform)
    }

    ///  ###### Signature:
    /// `LCE<Loading, Content, Failure>` -> `LCE<LoadingOut, ContentOut, FailureOut>`
    ///
    /// ###### EN:
    /// Transforms to `LCE<LoadingOut, ContentOut, FailureOut>` by applying the `loading` function if `LCE.loading`,
    /// the `content` function if `LCE.content`, or the `error` function if `LCE.error`.
    ///
    /// ###### RU:
    /// Трансформирует в `LCE<LoadingOut, ContentOut, FailureOut>`, применяя функцию `loading` если `LCE.loading`,
    /// функцию `content` если `LCE.content`, или функцию `error` если `LCE.error`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).map(
    ///     loading: { _ in "foo" },
    ///     content: { _ in "bar" },
    ///     error: { _ in "zoo" }
    /// ) // Result: .loading("foo")
    ///
    /// .content(2).map(
    ///     loading: { _ in "foo" },
    ///     content: { _ in "bar" },
    ///     error: { _ in "zoo" }
    /// ) // Result: .content("bar")
    ///
    /// .error(2).map(
    ///     loading: { _ in "foo" },
    ///     content: { _ in "bar" },
    ///     error: { _ in "zoo" }
    /// ) // Result: .error("zoo")
    /// ```
    func map<LoadingOut, ContentOut, FailureOut>(
        loading loadingTransform: (Loading) async -> LoadingOut,
        content contentTransform: (Content) async -> ContentOut,
        error errorTransform: (Failure) async -> FailureOut
    ) async -> LCE<LoadingOut, ContentOut, FailureOut> {
        return await self
            .mapLoading(loadingTransform)
            .mapContent(contentTransform)
            .mapError(errorTransform)
    }

    ///  ###### Signature:
    /// `LCE<Loading, Content, Failure>` -> `Result`
    ///
    /// ###### EN:
    /// Transforms `LCE<Loading, Content, Failure>` to the value `Out` by applying the function
    /// `loading` if `LCE.loading`, the function `content` if `LCE.content`, or the
    /// function `error` if `LCE.error`.
    ///
    /// ###### RU:
    /// Трансформирует `LCE<Loading, Content, Failure>` в значение `Out`, применяя функцию
    /// `loading` если `LCE.loading`, функцию `content` если `LCE.content`,или функцию
    /// `error` если `LCE.error`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).fold(
    ///     loading: { _ in "foo" },
    ///     content: { _ in "bar" },
    ///     error: { _ in "zoo" }
    /// ) // Result: "foo"
    ///
    /// .content(2).fold(
    ///     loading: { _ in "foo" },
    ///     content: { _ in "bar" },
    ///     error: { _ in "zoo" }
    /// ) // Result: "bar"
    ///
    /// .error(2).fold(
    ///     loading: { _ in "foo" },
    ///     content: { _ in "bar" },
    ///     error: { _ in "zoo" }
    /// ) // Result: "zoo"
    /// ```
    func fold<Out>(
        loading loadingTransform: (Loading) -> Out,
        content contentTransform: (Content) -> Out,
        error errorTransform: (Failure) -> Out
    ) -> Out {
        switch self {
        case let .loading(loading):
            loadingTransform(loading)

        case let .content(content):
            contentTransform(content)

        case let .error(error):
            errorTransform(error)
        }
    }

    ///  ###### Signature:
    /// `LCE<Loading, Content, Failure>` -> `Result`
    ///
    /// ###### EN:
    /// Transforms `LCE<Loading, Content, Failure>` to the value `Out` by applying the function
    /// `loading` if `LCE.loading`, the function `content` if `LCE.content`, or the
    /// function `error` if `LCE.error`.
    ///
    /// ###### RU:
    /// Трансформирует `LCE<Loading, Content, Failure>` в значение `Out`, применяя функцию
    /// `loading` если `LCE.loading`, функцию `content` если `LCE.content`,или функцию
    /// `error` если `LCE.error`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).fold(
    ///     loading: { _ in "foo" },
    ///     content: { _ in "bar" },
    ///     error: { _ in "zoo" }
    /// ) // Result: "foo"
    ///
    /// .content(2).fold(
    ///     loading: { _ in "foo" },
    ///     content: { _ in "bar" },
    ///     error: { _ in "zoo" }
    /// ) // Result: "bar"
    ///
    /// .error(2).fold(
    ///     loading: { _ in "foo" },
    ///     content: { _ in "bar" },
    ///     error: { _ in "zoo" }
    /// ) // Result: "zoo"
    /// ```
    func fold<Out>(
        loading loadingTransform: (Loading) async -> Out,
        content contentTransform: (Content) async -> Out,
        error errorTransform: (Failure) async -> Out
    ) async -> Out {
        switch self {
        case let .loading(loading):
            await loadingTransform(loading)

        case let .content(content):
            await contentTransform(content)

        case let .error(error):
            await errorTransform(error)
        }
    }

    /// ###### Signature:
    /// `LCE<Loading, Content, Failure>` -> `LCE<Out, Content, Failure>`
    ///
    /// ###### EN:
    /// Transforms to `LCE<Out, Content, Failure>` by applying the `transform` function if `LCE.loading`.
    ///
    /// ###### RU:
    /// Трансформирует в `LCE<Out, Content, Failure>`, применяя функцию `transform` если `LCE.loading`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).flatMapLoading { _ in .loading("foo") } // Result: .loading("foo")
    /// .loading(1).flatMapLoading { _ in .content(4) } // Result: .content(4)
    /// .loading(1).flatMapLoading { _ in .error(5) } // Result: .error(5)
    ///
    /// .content(2).flatMapLoading { _ in .loading("foo") } // Result: .content(2)
    /// .content(2).flatMapLoading { _ in .content(4) } // Result: .content(2)
    /// .content(2).flatMapLoading { _ in .error(5) } // Result: .content(2)
    ///
    /// .error(3).flatMapLoading { _ in .loading("foo") } // Result: .error(3)
    /// .error(3).flatMapLoading { _ in .content(4) } // Result: .error(3)
    /// .error(3).flatMapLoading { _ in .error(5) } // Result: .error(3)
    /// ```
    func flatMapLoading<Out>(
        _ transform: (Loading) -> LCE<Out, Content, Failure>
    ) -> LCE<Out, Content, Failure> {
        switch self {
        case let .loading(loading):
            transform(loading)

        case let .content(content):
            .content(content)

        case let .error(error):
            .error(error)
        }
    }

    /// ###### Signature:
    /// `LCE<Loading, Content, Failure>` -> `LCE<Out, Content, Failure>`
    ///
    /// ###### EN:
    /// Transforms to `LCE<Out, Content, Failure>` by applying the `transform` function if `LCE.loading`.
    ///
    /// ###### RU:
    /// Трансформирует в `LCE<Out, Content, Failure>`, применяя функцию `transform` если `LCE.loading`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).flatMapLoading { _ in .loading("foo") } // Result: .loading("foo")
    /// .loading(1).flatMapLoading { _ in .content(4) } // Result: .content(4)
    /// .loading(1).flatMapLoading { _ in .error(5) } // Result: .error(5)
    ///
    /// .content(2).flatMapLoading { _ in .loading("foo") } // Result: .content(2)
    /// .content(2).flatMapLoading { _ in .content(4) } // Result: .content(2)
    /// .content(2).flatMapLoading { _ in .error(5) } // Result: .content(2)
    ///
    /// .error(3).flatMapLoading { _ in .loading("foo") } // Result: .error(3)
    /// .error(3).flatMapLoading { _ in .content(4) } // Result: .error(3)
    /// .error(3).flatMapLoading { _ in .error(5) } // Result: .error(3)
    /// ```
    func flatMapLoading<Out>(
        _ transform: (Loading) async -> LCE<Out, Content, Failure>
    ) async -> LCE<Out, Content, Failure> {
        switch self {
        case let .loading(loading):
            await transform(loading)

        case let .content(content):
            .content(content)

        case let .error(error):
            .error(error)
        }
    }

    /// ###### Signature:
    /// `LCE<Loading, Content, Failure>` -> `LCE<Loading, Out, Failure>`
    ///
    /// ###### EN:
    /// Transforms to `LCE<Loading, Out, Failure>` by applying the `transform` function if `LCE.content`.
    ///
    /// ###### RU:
    /// Трансформирует в `LCE<Loading, Out, Failure>`, применяя функцию `transform` если `LCE.content`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).flatMapContent { _ in .loading(4) } // Result: .loading(1)
    /// .loading(1).flatMapContent { _ in .content("foo") } // Result: .loading(1)
    /// .loading(1).flatMapContent { _ in .error(5) } // Result: .loading(1)
    ///
    /// .content(2).flatMapContent { _ in .loading(4) } // Result: .loading(4)
    /// .content(2).flatMapContent { _ in .content("foo") } // Result: .content("foo")
    /// .content(2).flatMapContent { _ in .error(5) } // Result: .error(5)
    ///
    /// .error(3).flatMapContent { _ in .loading(4) } // Result: .error(3)
    /// .error(3).flatMapContent { _ in .content("foo") } // Result: .error(3)
    /// .error(3).flatMapContent { _ in .error(5) } // Result: .error(3)
    /// ```
    func flatMapContent<Out>(
        _ transform: (Content) -> LCE<Loading, Out, Failure>
    ) -> LCE<Loading, Out, Failure> {
        switch self {
        case let .content(content):
            transform(content)

        case let .loading(loading):
            .loading(loading)

        case let .error(error):
            .error(error)
        }
    }

    /// ###### Signature:
    /// `LCE<Loading, Content, Failure>` -> `LCE<Loading, Out, Failure>`
    ///
    /// ###### EN:
    /// Transforms to `LCE<Loading, Out, Failure>` by applying the `transform` function if `LCE.content`.
    ///
    /// ###### RU:
    /// Трансформирует в `LCE<Loading, Out, Failure>`, применяя функцию `transform` если `LCE.content`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).flatMapContent { _ in .loading(4) } // Result: .loading(1)
    /// .loading(1).flatMapContent { _ in .content("foo") } // Result: .loading(1)
    /// .loading(1).flatMapContent { _ in .error(5) } // Result: .loading(1)
    ///
    /// .content(2).flatMapContent { _ in .loading(4) } // Result: .loading(4)
    /// .content(2).flatMapContent { _ in .content("foo") } // Result: .content("foo")
    /// .content(2).flatMapContent { _ in .error(5) } // Result: .error(5)
    ///
    /// .error(3).flatMapContent { _ in .loading(4) } // Result: .error(3)
    /// .error(3).flatMapContent { _ in .content("foo") } // Result: .error(3)
    /// .error(3).flatMapContent { _ in .error(5) } // Result: .error(3)
    /// ```
    func flatMapContent<Out>(
        _ transform: (Content) async -> LCE<Loading, Out, Failure>
    ) async -> LCE<Loading, Out, Failure> {
        switch self {
        case let .content(content):
            await transform(content)

        case let .loading(loading):
            .loading(loading)

        case let .error(error):
            .error(error)
        }
    }

    /// ###### Signature:
    /// `LCE<Loading, Content, Failure>` -> `LCE<Loading, Content, Out>`
    ///
    /// ###### EN:
    /// Transforms to `LCE<Loading, Content, Out>` by applying the `transform` function if `LCE.error`.
    ///
    /// ###### RU:
    /// Трансформирует в `LCE<Loading, Content, Out>`, применяя функцию `transform` если `LCE.error`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).flatMapError { _ in .loading(4) } // Result: .loading(1)
    /// .loading(1).flatMapError { _ in .content(5) } // Result: .loading(1)
    /// .loading(1).flatMapError { _ in .error("foo") } // Result: .loading(1)
    ///
    /// .content(2).flatMapError { _ in .loading(4) } // Result: .content(2)
    /// .content(2).flatMapError { _ in .content(5) } // Result: .content(2)
    /// .content(2).flatMapError { _ in .error("foo") } // Result: .content(2)
    ///
    /// .error(3).flatMapError { _ in .loading(4) } // Result: .loading(4)
    /// .error(3).flatMapError { _ in .content(5) } // Result: .content(5)
    /// .error(3).flatMapError { _ in .error("foo") } // Result: .error("foo")
    /// ```
    func flatMapError<Out>(
        _ transform: (Failure) -> LCE<Loading, Content, Out>
    ) -> LCE<Loading, Content, Out> {
        switch self {
        case let .error(error):
            transform(error)

        case let .loading(loading):
            .loading(loading)

        case let .content(content):
            .content(content)
        }
    }

    /// ###### Signature:
    /// `LCE<Loading, Content, Failure>` -> `LCE<Loading, Content, Out>`
    ///
    /// ###### EN:
    /// Transforms to `LCE<Loading, Content, Out>` by applying the `transform` function if `LCE.error`.
    ///
    /// ###### RU:
    /// Трансформирует в `LCE<Loading, Content, Out>`, применяя функцию `transform` если `LCE.error`.
    ///
    /// ###### Example:
    /// ```
    /// .loading(1).flatMapError { _ in .loading(4) } // Result: .loading(1)
    /// .loading(1).flatMapError { _ in .content(5) } // Result: .loading(1)
    /// .loading(1).flatMapError { _ in .error("foo") } // Result: .loading(1)
    ///
    /// .content(2).flatMapError { _ in .loading(4) } // Result: .content(2)
    /// .content(2).flatMapError { _ in .content(5) } // Result: .content(2)
    /// .content(2).flatMapError { _ in .error("foo") } // Result: .content(2)
    ///
    /// .error(3).flatMapError { _ in .loading(4) } // Result: .loading(4)
    /// .error(3).flatMapError { _ in .content(5) } // Result: .content(5)
    /// .error(3).flatMapError { _ in .error("foo") } // Result: .error("foo")
    /// ```
    func flatMapError<Out>(
        _ transform: (Failure) async -> LCE<Loading, Content, Out>
    ) async -> LCE<Loading, Content, Out> {
        switch self {
        case let .error(error):
            await transform(error)

        case let .loading(loading):
            .loading(loading)

        case let .content(content):
            .content(content)
        }
    }
}
