//
//  Result+Zip.swift
//  Monadic
//
//  Created by Pavel Annin on 01.02.2025.
//

public extension Result {
    /// ###### Signature:
    /// `Result<Success, Failure>` & `Result<Success2, Failure>` -> `Result<Result, Failure>`
    ///
    /// ###### EN:
    /// Combines two `Result.success` to a single value by applying the `transform` function.
    ///
    /// ###### RU:
    /// Объединяет два `Result.success` в одно значение, применяя функцию `transform`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1)
    ///     .zip(.success(1)) { r1, r2 in r1 + r2 } // Result: success(2)
    ///
    /// Result<String, Int>.success(1)
    ///     .zip(.failure("foo")) { r1, r2 -> r1 + r2 } // Result: failure("foo")
    ///
    /// Result<String, Int>.failure("foo")
    ///     .zip(Result<String, Int>.success(1)) { r1, r2 -> r1 + r2 } // Result: failure("foo")
    ///
    /// Result<String, Int>.failure("foo")
    ///     .zip(Result<String, Int>.failure("foo")) { r1, r2 -> r1 + r2 } // Result: Failure("foo")
    /// ```
    func zip<Success2, Out>(
        _ result: Result<Success2, Failure>,
        _ transform: (Success, Success2) -> Out
    ) -> Result<Out, Failure> {
        self.flatMap { success1 in
            result.map { success2 in transform(success1, success2) }
        }
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` & `Result<Success2, Failure>` -> `Result<Result, Failure>`
    ///
    /// ###### EN:
    /// Combines two `Result.success` to a single value by applying the `transform` function.
    ///
    /// ###### RU:
    /// Объединяет два `Result.success` в одно значение, применяя функцию `transform`.
    ///
    /// ###### Example:
    /// ```
    /// .success(1)
    ///     .zip(.success(1)) { r1, r2 in r1 + r2 } // Result: success(2)
    ///
    /// Result<String, Int>.success(1)
    ///     .zip(.failure("foo")) { r1, r2 -> r1 + r2 } // Result: failure("foo")
    ///
    /// Result<String, Int>.failure("foo")
    ///     .zip(Result<String, Int>.success(1)) { r1, r2 -> r1 + r2 } // Result: failure("foo")
    ///
    /// Result<String, Int>.failure("foo")
    ///     .zip(Result<String, Int>.failure("foo")) { r1, r2 -> r1 + r2 } // Result: Failure("foo")
    /// ```
    func zip<Success2, Out>(
        _ result: Result<Success2, Failure>,
        _ transform: (Success, Success2) async -> Out
    ) async -> Result<Out, Failure> {
        await self.flatMap { success1 in
            await result.map { success2 in await transform(success1, success2) }
        }
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` & `Result<Success2, Failure>` -> `Result<(Success, Success2), Failure>`
    ///
    /// ###### EN:
    /// Combines two `Result.success` to a single value.
    ///
    /// ###### RU:
    /// Объединяет два `Result.success` в одно значение.
    func zip<Success2>(_ result: Result<Success2, Failure>) -> Result<(Success, Success2), Failure> {
        self.zip(result) { r1, r2 in (r1, r2) }
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` & `Result<Success2, Failure>` & `Result<Success3, Failure>` -> `Result<Out, Failure>`
    ///
    /// ###### EN:
    /// Combines three `Result.success` to a single value by applying the `transform` function.
    ///
    /// ###### RU:
    /// Объединяет три `Result.success` в одно значение, применяя функцию `transform`.
    func zip<Success2, Success3, Out>(
        _ result2: Result<Success2, Failure>,
        _ result3: Result<Success3, Failure>,
        _ transform: (Success, Success2, Success3) -> Out
    ) -> Result<Out, Failure> {
        self.flatMap { success1 in
            result2.flatMap { success2 in
                result3.map { success3 in transform(success1, success2, success3) }
            }
        }
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` & `Result<Success2, Failure>` & `Result<Success3, Failure>` -> `Result<Out, Failure>`
    ///
    /// ###### EN:
    /// Combines three `Result.success` to a single value by applying the `transform` function.
    ///
    /// ###### RU:
    /// Объединяет три `Result.success` в одно значение, применяя функцию `transform`.
    func zip<Success2, Success3, Out>(
        _ result2: Result<Success2, Failure>,
        _ result3: Result<Success3, Failure>,
        _ transform: (Success, Success2, Success3) async -> Out
    ) async -> Result<Out, Failure> {
        await self.flatMap { success1 in
            await result2.flatMap { success2 in
                await result3.map { success3 in await transform(success1, success2, success3) }
            }
        }
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` & `Result<Success2, Failure>`  & `Result<Success3, Failure>` -> `Result<(Success, Success2, Success3), Failure>`
    ///
    /// ###### EN:
    /// Combines three `Result.success` to a single value.
    ///
    /// ###### RU:
    /// Объединяет три `Result.success` в одно значение.
    func zip<Success2, Success3>(
        _ result2: Result<Success2, Failure>,
        _ result3: Result<Success3, Failure>
    ) -> Result<(Success, Success2, Success3), Failure> {
        self.zip(result2, result3) { r1, r2, r3 in (r1, r2, r3) }
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` & `Result<Success2, Failure>` & `Result<Success3, Failure>` &
    /// `Result<Success4, Failure>` -> `Result<Out, Failure>`
    ///
    /// ###### EN:
    /// Combines four `Result.success` to a single value by applying the `transform` function.
    ///
    /// ###### RU:
    /// Объединяет четыре `Result.success` в одно значение, применяя функцию `transform`.
    func zip<Success2, Success3, Success4, Out>(
        _ result2: Result<Success2, Failure>,
        _ result3: Result<Success3, Failure>,
        _ result4: Result<Success4, Failure>,
        _ transform: (Success, Success2, Success3, Success4) -> Out
    ) -> Result<Out, Failure> {
        self.flatMap { success1 in
            result2.flatMap { success2 in
                result3.flatMap { success3 in
                    result4.map { success4 in transform(success1, success2, success3, success4) }
                }
            }
        }
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` & `Result<Success2, Failure>` & `Result<Success3, Failure>` &
    /// `Result<Success4, Failure>` -> `Result<Out, Failure>`
    ///
    /// ###### EN:
    /// Combines four `Result.success` to a single value by applying the `transform` function.
    ///
    /// ###### RU:
    /// Объединяет четыре `Result.success` в одно значение, применяя функцию `transform`.
    func zip<Success2, Success3, Success4, Out>(
        _ result2: Result<Success2, Failure>,
        _ result3: Result<Success3, Failure>,
        _ result4: Result<Success4, Failure>,
        _ transform: (Success, Success2, Success3, Success4) async -> Out
    ) async -> Result<Out, Failure> {
        await self.flatMap { success1 in
            await result2.flatMap { success2 in
                await result3.flatMap { success3 in
                    await result4.map { success4 in await transform(success1, success2, success3, success4) }
                }
            }
        }
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` & `Result<Success2, Failure>` & `Result<Success3, Failure>` &
    /// `Result<Success4, Failure>` -> `Result<(Success, Success2, Success3, Success4), Failure>`
    ///
    /// ###### EN:
    /// Combines four `Result.success` to a single value.
    ///
    /// ###### RU:
    /// Объединяет четыре `Result.success` to a single value.
    func zip<Success2, Success3, Success4>(
        _ result2: Result<Success2, Failure>,
        _ result3: Result<Success3, Failure>,
        _ result4: Result<Success4, Failure>
    ) -> Result<(Success, Success2, Success3, Success4), Failure> {
        self.zip(result2, result3, result4) { r1, r2, r3, r4 in (r1, r2, r3, r4) }
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` & `Result<Success2, Failure>` & `Result<Success3, Failure>` &
    /// `Result<Success4, Failure>` & `Result<Success5, Failure>` -> `Result<Out, Failure>`
    ///
    /// ###### EN:
    /// Combines five `Result.success` to a single value by applying the `transform` function.
    ///
    /// ###### RU:
    /// Объединяет пять `Result.success` в одно значение, применяя функцию `transform`.
    func zip<Success2, Success3, Success4, Success5, Out>(
        _ result2: Result<Success2, Failure>,
        _ result3: Result<Success3, Failure>,
        _ result4: Result<Success4, Failure>,
        _ result5: Result<Success5, Failure>,
        _ transform: (Success, Success2, Success3, Success4, Success5) -> Out
    ) -> Result<Out, Failure> {
        self.flatMap { success1 in
            result2.flatMap { success2 in
                result3.flatMap { success3 in
                    result4.flatMap { success4 in
                        result5.map { success5 in transform(success1, success2, success3, success4, success5) }
                    }
                }
            }
        }
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` & `Result<Success2, Failure>` & `Result<Success3, Failure>` &
    /// `Result<Success4, Failure>` & `Result<Success5, Failure>` -> `Result<Out, Failure>`
    ///
    /// ###### EN:
    /// Combines five `Result.success` to a single value by applying the `transform` function.
    ///
    /// ###### RU:
    /// Объединяет пять `Result.success` в одно значение, применяя функцию `transform`.
    func zip<Success2, Success3, Success4, Success5, Out>(
        _ result2: Result<Success2, Failure>,
        _ result3: Result<Success3, Failure>,
        _ result4: Result<Success4, Failure>,
        _ result5: Result<Success5, Failure>,
        _ transform: (Success, Success2, Success3, Success4, Success5) async -> Out
    ) async -> Result<Out, Failure> {
        await self.flatMap { success1 in
            await result2.flatMap { success2 in
                await result3.flatMap { success3 in
                    await result4.flatMap { success4 in
                        await result5.map { success5 in await transform(success1, success2, success3, success4, success5) }
                    }
                }
            }
        }
    }

    /// ###### Signature:
    /// `Result<Success, Failure>` & `Result<Success2, Failure>` & `Result<Success3, Failure>` &
    /// `Result<Success4, Failure>` & `Result<Success5, Failure>` -> `Result<(Success, Success2, Success3, Success4, Success5), Failure>`
    ///
    /// ###### EN:
    /// Combines five `Result.success` to a single value.
    ///
    /// ###### RU:
    /// Объединяет пять `Result.success` to a single value.
    func zip<Success2, Success3, Success4, Success5>(
        _ result2: Result<Success2, Failure>,
        _ result3: Result<Success3, Failure>,
        _ result4: Result<Success4, Failure>,
        _ result5: Result<Success5, Failure>
    ) -> Result<(Success, Success2, Success3, Success4, Success5), Failure> {
        self.zip(result2, result3, result4, result5) { r1, r2, r3, r4, r5 in (r1, r2, r3, r4, r5) }
    }
}
