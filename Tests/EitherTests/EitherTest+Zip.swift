//
//  EitherTest+Zip.swift
//  Monadic
//
//  Created by Pavel Annin on 01.02.2025.
//

import XCTest
@testable import Either

final class EitherZipTest: XCTestCase {
    func testZip2() {
        func f(_ either: Either<Int, Int>) -> Either<Int, String> {
            either.zip(.right(())) { _, _ in "foo" }
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertEqual(.left(1), f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertEqual(.right("foo"), f(right))
    }

    func testZip2Async() async {
        func f(_ either: Either<Int, Int>) async -> Either<Int, String> {
            let fetch: () async -> String = { "foo" }
            return await either.zip(.right(())) { _, _ in await fetch() }
        }

        let left: Either<Int, Int> = .left(1)
        let leftValue = await f(left)
        XCTAssertEqual(.left(1), leftValue)

        let right: Either<Int, Int> = .right(2)
        let rightValue = await f(right)
        XCTAssertEqual(.right("foo"), rightValue)
    }

    func testZip3() {
        func f(_ either: Either<Int, Int>) -> Either<Int, String> {
            either.zip(.right(()), .right(())) { _, _, _ in "foo" }
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertEqual(.left(1), f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertEqual(.right("foo"), f(right))
    }

    func testZip3Async() async {
        func f(_ either: Either<Int, Int>) async -> Either<Int, String> {
            let fetch: () async -> String = { "foo" }
            return await either.zip(.right(()), .right(())) { _, _, _ in await fetch() }
        }

        let left: Either<Int, Int> = .left(1)
        let leftValue = await f(left)
        XCTAssertEqual(.left(1), leftValue)

        let right: Either<Int, Int> = .right(2)
        let rightValue = await f(right)
        XCTAssertEqual(.right("foo"), rightValue)
    }

    func testZip4() {
        func f(_ either: Either<Int, Int>) -> Either<Int, String> {
            either.zip(.right(()), .right(()), .right(())) { _, _, _, _ in "foo" }
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertEqual(.left(1), f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertEqual(.right("foo"), f(right))
    }

    func testZip4Async() async {
        func f(_ either: Either<Int, Int>) async -> Either<Int, String> {
            let fetch: () async -> String = { "foo" }
            return await either.zip(.right(()), .right(()), .right(())) { _, _, _, _ in await fetch() }
        }

        let left: Either<Int, Int> = .left(1)
        let leftValue = await f(left)
        XCTAssertEqual(.left(1), leftValue)

        let right: Either<Int, Int> = .right(2)
        let rightValue = await f(right)
        XCTAssertEqual(.right("foo"), rightValue)
    }

    func testZip5() {
        func f(_ either: Either<Int, Int>) -> Either<Int, String> {
            either.zip(.right(()), .right(()), .right(()), .right(())) { _, _, _, _, _ in "foo" }
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertEqual(.left(1), f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertEqual(.right("foo"), f(right))
    }

    func testZip5Async() async {
        func f(_ either: Either<Int, Int>) async -> Either<Int, String> {
            let fetch: () async -> String = { "foo" }
            return await either.zip(.right(()), .right(()), .right(()), .right(())) { _, _, _, _, _ in await fetch() }
        }

        let left: Either<Int, Int> = .left(1)
        let leftValue = await f(left)
        XCTAssertEqual(.left(1), leftValue)

        let right: Either<Int, Int> = .right(2)
        let rightValue = await f(right)
        XCTAssertEqual(.right("foo"), rightValue)
    }
}
