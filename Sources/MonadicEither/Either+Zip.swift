//
//  Either+Zip.swift
//  Monadic
//
//  Created by Pavel Annin on 26.01.2025.
//

public extension Either {
    /// ###### Signature:
    /// `Either<Left, Right>` & `Either<Left, Right2>` -> `Either<Left, Result>`
    ///
    /// ###### EN:
    /// Combines two `Either.right` to a single value by applying the `transform` function.
    ///
    /// ###### RU:
    /// Объединяет два `Either.right` в одно значение, применяя функцию `transform`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1)
    ///     .zip(Either<Int, Int>.right(1)) { r1, r2 in r1 + r2 } // Result: right(2)
    ///
    /// Either<String, Int>.right(1)
    ///     .zip(.left("foo")) { r1, r2 -> r1 + r2 } // Result: left("foo")
    ///
    /// Either<String, Int>.left("foo")
    ///     .zip(Either<String, Int>.right(1)) { r1, r2 -> r1 + r2 } // Result: left("foo")
    ///
    /// Either<String, Int>.left("foo")
    ///     .zip(Either<String, Int>.left("foo")) { r1, r2 -> r1 + r2 } // Result: Left("foo")
    /// ```
    func zip<Right2, Out>(
        _ either: Either<Left, Right2>,
        _ transform: (Right, Right2) -> Out
    ) -> Either<Left, Out> {
        self.flatMap { right1 in
            either.map { right2 in transform(right1, right2) }
        }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` & `Either<Left, Right2>` -> `Either<Left, Result>`
    ///
    /// ###### EN:
    /// Combines two `Either.right` to a single value by applying the `transform` function.
    ///
    /// ###### RU:
    /// Объединяет два `Either.right` в одно значение, применяя функцию `transform`.
    ///
    /// ###### Example:
    /// ```
    /// Either<Int, Int>.right(1)
    ///     .zip(Either<Int, Int>.right(1)) { r1, r2 in r1 + r2 } // Result: right(2)
    ///
    /// Either<String, Int>.right(1)
    ///     .zip(.left("foo")) { r1, r2 -> r1 + r2 } // Result: left("foo")
    ///
    /// Either<String, Int>.left("foo")
    ///     .zip(Either<String, Int>.right(1)) { r1, r2 -> r1 + r2 } // Result: left("foo")
    ///
    /// Either<String, Int>.left("foo")
    ///     .zip(Either<String, Int>.left("foo")) { r1, r2 -> r1 + r2 } // Result: Left("foo")
    /// ```
    func zip<Right2, Out>(
        _ either: Either<Left, Right2>,
        _ transform: (Right, Right2) async -> Out
    ) async -> Either<Left, Out> {
        await self.flatMap { right1 in
            await either.map { right2 in await transform(right1, right2) }
        }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` & `Either<Left, Right2>` -> `Either<Left, (Right, Right2)>`
    ///
    /// ###### EN:
    /// Combines two `Either.right` to a single value.
    ///
    /// ###### RU:
    /// Объединяет два `Either.right` в одно значение.
    func zip<Right2>(_ either: Either<Left, Right2>) -> Either<Left, (Right, Right2)> {
        self.zip(either) { r1, r2 in (r1, r2) }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` & `Either<Left, Right2>` & `Either<Left, Right3>` -> `Either<Left, Out>`
    ///
    /// ###### EN:
    /// Combines three `Either.right` to a single value by applying the `transform` function.
    ///
    /// ###### RU:
    /// Объединяет три `Either.right` в одно значение, применяя функцию `transform`.
    func zip<Right2, Right3, Out>(
        _ either2: Either<Left, Right2>,
        _ either3: Either<Left, Right3>,
        _ transform: (Right, Right2, Right3) -> Out
    ) -> Either<Left, Out> {
        self.flatMap { right1 in
            either2.flatMap { right2 in
                either3.map { right3 in transform(right1, right2, right3) }
            }
        }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` & `Either<Left, Right2>` & `Either<Left, Right3>` -> `Either<Left, Out>`
    ///
    /// ###### EN:
    /// Combines three `Either.right` to a single value by applying the `transform` function.
    ///
    /// ###### RU:
    /// Объединяет три `Either.right` в одно значение, применяя функцию `transform`.
    func zip<Right2, Right3, Out>(
        _ either2: Either<Left, Right2>,
        _ either3: Either<Left, Right3>,
        _ transform: (Right, Right2, Right3) async -> Out
    ) async -> Either<Left, Out> {
        await self.flatMap { right1 in
            await either2.flatMap { right2 in
                await either3.map { right3 in await transform(right1, right2, right3) }
            }
        }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` & `Either<Left, Right2>`  & `Either<Left, Right3>` -> `Either<Left, (Right, Right2, Right3)>`
    ///
    /// ###### EN:
    /// Combines three `Either.right` to a single value.
    ///
    /// ###### RU:
    /// Объединяет три `Either.right` в одно значение.
    func zip<Right2, Right3>(
        _ either2: Either<Left, Right2>,
        _ either3: Either<Left, Right3>
    ) -> Either<Left, (Right, Right2, Right3)> {
        self.zip(either2, either3) { r1, r2, r3 in (r1, r2, r3) }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` & `Either<Left, Right2>` & `Either<Left, Right3>` &
    /// `Either<Left, Right4>` -> `Either<Left, Out>`
    ///
    /// ###### EN:
    /// Combines four `Either.right` to a single value by applying the `transform` function.
    ///
    /// ###### RU:
    /// Объединяет четыре `Either.right` в одно значение, применяя функцию `transform`.
    func zip<Right2, Right3, Right4, Out>(
        _ either2: Either<Left, Right2>,
        _ either3: Either<Left, Right3>,
        _ either4: Either<Left, Right4>,
        _ transform: (Right, Right2, Right3, Right4) -> Out
    ) -> Either<Left, Out> {
        self.flatMap { right1 in
            either2.flatMap { right2 in
                either3.flatMap { right3 in
                    either4.map { right4 in transform(right1, right2, right3, right4) }
                }
            }
        }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` & `Either<Left, Right2>` & `Either<Left, Right3>` &
    /// `Either<Left, Right4>` -> `Either<Left, Out>`
    ///
    /// ###### EN:
    /// Combines four `Either.right` to a single value by applying the `transform` function.
    ///
    /// ###### RU:
    /// Объединяет четыре `Either.right` в одно значение, применяя функцию `transform`.
    func zip<Right2, Right3, Right4, Out>(
        _ either2: Either<Left, Right2>,
        _ either3: Either<Left, Right3>,
        _ either4: Either<Left, Right4>,
        _ transform: (Right, Right2, Right3, Right4) async -> Out
    ) async -> Either<Left, Out> {
        await self.flatMap { right1 in
            await either2.flatMap { right2 in
                await either3.flatMap { right3 in
                    await either4.map { right4 in await transform(right1, right2, right3, right4) }
                }
            }
        }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` & `Either<Left, Right2>` & `Either<Left, Right3>` &
    /// `Either<Left, Right4>` -> `Either<Left, (Right, Right2, Right3, Right4)>`
    ///
    /// ###### EN:
    /// Combines four `Either.right` to a single value.
    ///
    /// ###### RU:
    /// Объединяет четыре `Either.right` to a single value.
    func zip<Right2, Right3, Right4>(
        _ either2: Either<Left, Right2>,
        _ either3: Either<Left, Right3>,
        _ either4: Either<Left, Right4>
    ) -> Either<Left, (Right, Right2, Right3, Right4)> {
        self.zip(either2, either3, either4) { r1, r2, r3, r4 in (r1, r2, r3, r4) }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` & `Either<Left, Right2>` & `Either<Left, Right3>` &
    /// `Either<Left, Right4>` & `Either<Left, Right5>` -> `Either<Left, Out>`
    ///
    /// ###### EN:
    /// Combines five `Either.right` to a single value by applying the `transform` function.
    ///
    /// ###### RU:
    /// Объединяет пять `Either.right` в одно значение, применяя функцию `transform`.
    func zip<Right2, Right3, Right4, Right5, Out>(
        _ either2: Either<Left, Right2>,
        _ either3: Either<Left, Right3>,
        _ either4: Either<Left, Right4>,
        _ either5: Either<Left, Right5>,
        _ transform: (Right, Right2, Right3, Right4, Right5) -> Out
    ) -> Either<Left, Out> {
        self.flatMap { right1 in
            either2.flatMap { right2 in
                either3.flatMap { right3 in
                    either4.flatMap { right4 in
                        either5.map { right5 in transform(right1, right2, right3, right4, right5) }
                    }
                }
            }
        }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` & `Either<Left, Right2>` & `Either<Left, Right3>` &
    /// `Either<Left, Right4>` & `Either<Left, Right5>` -> `Either<Left, Out>`
    ///
    /// ###### EN:
    /// Combines five `Either.right` to a single value by applying the `transform` function.
    ///
    /// ###### RU:
    /// Объединяет пять `Either.right` в одно значение, применяя функцию `transform`.
    func zip<Right2, Right3, Right4, Right5, Out>(
        _ either2: Either<Left, Right2>,
        _ either3: Either<Left, Right3>,
        _ either4: Either<Left, Right4>,
        _ either5: Either<Left, Right5>,
        _ transform: (Right, Right2, Right3, Right4, Right5) async -> Out
    ) async -> Either<Left, Out> {
        await self.flatMap { right1 in
            await either2.flatMap { right2 in
                await either3.flatMap { right3 in
                    await either4.flatMap { right4 in
                        await either5.map { right5 in await transform(right1, right2, right3, right4, right5) }
                    }
                }
            }
        }
    }

    /// ###### Signature:
    /// `Either<Left, Right>` & `Either<Left, Right2>` & `Either<Left, Right3>` &
    /// `Either<Left, Right4>` & `Either<Left, Right5>` -> `Either<Left, (Right, Right2, Right3, Right4, Right5)>`
    ///
    /// ###### EN:
    /// Combines five `Either.right` to a single value.
    ///
    /// ###### RU:
    /// Объединяет пять `Either.right` to a single value.
    func zip<Right2, Right3, Right4, Right5>(
        _ either2: Either<Left, Right2>,
        _ either3: Either<Left, Right3>,
        _ either4: Either<Left, Right4>,
        _ either5: Either<Left, Right5>
    ) -> Either<Left, (Right, Right2, Right3, Right4, Right5)> {
        self.zip(either2, either3, either4, either5) { r1, r2, r3, r4, r5 in (r1, r2, r3, r4, r5) }
    }
}
