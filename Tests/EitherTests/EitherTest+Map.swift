//
//  EitherTest+Map.swift
//  Monadic
//
//  Created by Pavel Annin on 27.01.2025.
//

import XCTest
@testable import Either

final class EitherMapTest: XCTestCase {
    func testMap() {
        func f(_ either: Either<Int, Int>) -> Either<Int, String> {
            either.map { _ in "foo" }
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertEqual(.left(1), f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertEqual(.right("foo"), f(right))
    }

    func testMapAsync() async {
        func f(_ either: Either<Int, Int>) async -> Either<Int, String> {
            let fetch: () async -> String = { "foo" }
            return await either.map { _ in await fetch() }
        }

        let left: Either<Int, Int> = .left(1)
        let leftValue = await f(left)
        XCTAssertEqual(.left(1), leftValue)

        let right: Either<Int, Int> = .right(2)
        let rightValue = await f(right)
        XCTAssertEqual(.right("foo"), rightValue)
    }

    func testMapLeft() {
        func f(_ either: Either<Int, Int>) -> Either<String, Int> {
            either.mapLeft { _ in "foo" }
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertEqual(.left("foo"), f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertEqual(.right(2), f(right))
    }

    func testMapLeftAsync() async {
        func f(_ either: Either<Int, Int>) async -> Either<String, Int> {
            let fetch: () async -> String = { "foo" }
            return await either.mapLeft { _ in await fetch() }
        }

        let left: Either<Int, Int> = .left(1)
        let leftValue = await f(left)
        XCTAssertEqual(.left("foo"), leftValue)

        let right: Either<Int, Int> = .right(2)
        let rightValue = await f(right)
        XCTAssertEqual(.right(2), rightValue)
    }

    func testBiMap() {
        func f(_ either: Either<Int, Int>) -> Either<String, String> {
            either.bimap(left: { _ in "foo" }, right: { _ in "bar" })
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertEqual(.left("foo"), f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertEqual(.right("bar"), f(right))
    }

    func testBiMapAsync() async {
        func f(_ either: Either<Int, Int>) async -> Either<String, String> {
            let leftFetch: () async -> String = { "foo" }
            let rightFetch: () async -> String = { "bar" }
            return await either.bimap(left: { _ in await leftFetch() }, right: { _ in await rightFetch() })
        }

        let left: Either<Int, Int> = .left(1)
        let leftValue = await f(left)
        XCTAssertEqual(.left("foo"), leftValue)

        let right: Either<Int, Int> = .right(2)
        let rightValue = await f(right)
        XCTAssertEqual(.right("bar"), rightValue)
    }

    func testFold() {
        func f(_ either: Either<Int, Int>) -> String {
            either.fold(left: { _ in "foo" }, right: { _ in "bar" })
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertEqual("foo", f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertEqual("bar", f(right))
    }

    func testFoldAsync() async {
        func f(_ either: Either<Int, Int>) async -> String {
            let leftFetch: () async -> String = { "foo" }
            let rightFetch: () async -> String = { "bar" }
            return await either.fold(left: { _ in await leftFetch() }, right: { _ in await rightFetch() })
        }

        let left: Either<Int, Int> = .left(1)
        let leftValue = await f(left)
        XCTAssertEqual("foo", leftValue)

        let right: Either<Int, Int> = .right(2)
        let rightValue = await f(right)
        XCTAssertEqual("bar", rightValue)
    }

    func testFoldLeft() {
        func f(_ either: Either<Int, Int>) -> String {
            either.foldLeft(initial: "bar") { _ in "foo" }
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertEqual("foo", f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertEqual("bar", f(right))
    }

    func testFoldLeftAsync() async {
        func f(_ either: Either<Int, Int>) async -> String {
            let leftFetch: () async -> String = { "foo" }
            return await either.foldLeft(initial: "bar") { _ in await leftFetch() }
        }

        let left: Either<Int, Int> = .left(1)
        let leftValue = await f(left)
        XCTAssertEqual("foo", leftValue)

        let right: Either<Int, Int> = .right(2)
        let rightValue = await f(right)
        XCTAssertEqual("bar", rightValue)
    }

    func testFoldRight() {
        func f(_ either: Either<Int, Int>) -> String {
            either.foldRight(initial: "foo") { _ in "bar" }
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertEqual("foo", f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertEqual("bar", f(right))
    }

    func testFoldRightAsync() async {
        func f(_ either: Either<Int, Int>) async -> String {
            let rightFetch: () async -> String = { "bar" }
            return await either.foldRight(initial: "foo") { _ in await rightFetch() }
        }

        let left: Either<Int, Int> = .left(1)
        let leftValue = await f(left)
        XCTAssertEqual("foo", leftValue)

        let right: Either<Int, Int> = .right(2)
        let rightValue = await f(right)
        XCTAssertEqual("bar", rightValue)
    }

    func testFlatMap() {
        let result: Either<Int, String> = Either.right("bar")
        func f(_ either: Either<Int, Int>) -> Either<Int, String> {
            either.flatMap { _ in result }
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertEqual(.left(1), f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertEqual(result, f(right))
    }

    func testFlatMapAsync() async {
        let result: Either<Int, String> = Either.right("bar")
        func f(_ either: Either<Int, Int>) async -> Either<Int, String> {
            let fetch: () async -> Either<Int, String> = { result }
            return await either.flatMap { _ in await fetch() }
        }

        let left: Either<Int, Int> = .left(1)
        let leftValue = await f(left)
        XCTAssertEqual(.left(1), leftValue)

        let right: Either<Int, Int> = .right(2)
        let rightValue = await f(right)
        XCTAssertEqual(result, rightValue)
    }

    func testFlatMapLeft() {
        let result: Either<String, Int> = Either.left("foo")
        func f(_ either: Either<Int, Int>) -> Either<String, Int> {
            either.flatMapLeft { _ in result }
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertEqual(result, f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertEqual(.right(2), f(right))
    }

    func testFlatMapLeftAsync() async {
        let result: Either<String, Int> = Either.left("foo")
        func f(_ either: Either<Int, Int>) async -> Either<String, Int> {
            let fetch: () async -> Either<String, Int> = { result }
            return await either.flatMapLeft { _ in await fetch() }
        }

        let left: Either<Int, Int> = .left(1)
        let leftValue = await f(left)
        XCTAssertEqual(result, leftValue)

        let right: Either<Int, Int> = .right(2)
        let rightValue = await f(right)
        XCTAssertEqual(.right(2), rightValue)
    }

    func testSwap() {
        func f(_ either: Either<Int, Int>) -> Either<Int, Int> {
            either.swap()
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertEqual(.right(1), f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertEqual(.left(2), f(right))
    }

    func testSwapAsync() async {
        func f(_ either: Either<Int, Int>) async -> Either<Int, Int> {
            return await either.swap()
        }

        let left: Either<Int, Int> = .left(1)
        let leftValue = await f(left)
        XCTAssertEqual(.right(1), leftValue)

        let right: Either<Int, Int> = .right(2)
        let rightValue = await f(right)
        XCTAssertEqual(.left(2), rightValue)
    }

    func testFlatten() {
        func f(_ either: Either<Int, Either<Int, Int>>) -> Either<Int, Int> {
            either.flatten()
        }

        let left: Either<Int, Either<Int, Int>> = .left(1)
        XCTAssertEqual(.left(1), f(left))

        let right: Either<Int, Either<Int, Int>> = .right(.right(2))
        XCTAssertEqual(.right(2), f(right))
    }

    func testFlattenAsync() async {
        func f(_ either: Either<Int, Either<Int, Int>>) async -> Either<Int, Int> {
            await either.flatten()
        }

        let left: Either<Int, Either<Int, Int>> = .left(1)
        let leftValue = await f(left)
        XCTAssertEqual(.left(1), leftValue)

        let right: Either<Int, Either<Int, Int>> = .right(.right(2))
        let rightValue = await f(right)
        XCTAssertEqual(.right(2), rightValue)
    }
}
