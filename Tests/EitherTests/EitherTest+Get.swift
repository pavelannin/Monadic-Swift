//
//  EitherTest+Get.swift
//  Monadic
//
//  Created by Pavel Annin on 26.01.2025.
//

import XCTest
@testable import MonadicEither

final class EitherGetTests: XCTestCase {
    func testIsLeft() throws {
        func f(_ either: Either<Int, Int>) -> Bool {
            either.isLeft
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertTrue(f(left))

        let right: Either<Int, Int> = .right(1)
        XCTAssertFalse(f(right))
    }

    func testIsRight() throws {
        func f(_ either: Either<Int, Int>) -> Bool {
            either.isRight
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertFalse(f(left))

        let right: Either<Int, Int> = .right(1)
        XCTAssertTrue(f(right))
    }

    func testLeftOrNil() throws {
        func f(_ either: Either<Int, Int>) -> Int? {
            either.leftOrNil()
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertNotNil(f(left))
        XCTAssertEqual(1, f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertNil(f(right))
    }

    func testRightOrNil() throws {
        func f(_ either: Either<Int, Int>) -> Int? {
            either.rightOrNil()
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertNil(f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertNotNil(f(right))
        XCTAssertEqual(2, f(right))
    }

    func testLeftOrDefault() throws {
        func f(_ either: Either<Int, Int>) -> Int {
            either.leftOrDefault(default: 0)
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertEqual(1, f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertEqual(0, f(right))
    }

    func testRightOrDefault() throws {
        func f(_ either: Either<Int, Int>) -> Int {
            either.rightOrDefault(default: 0)
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertEqual(0, f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertEqual(2, f(right))
    }

    func testLeftOrElse() throws {
        func f(_ either: Either<Int, Int>) -> Int {
            either.leftOrElse { _ in 0 }
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertEqual(1, f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertEqual(0, f(right))
    }

    func testLeftOrElseAsync() async throws {
        func f(_ either: Either<Int, Int>) async -> Int? {
            let fetch: () async -> Int = { 0 }
            return await either.leftOrElse { _ in await fetch() }
        }

        let left: Either<Int, Int> = .left(1)
        let leftValue = await f(left)
        XCTAssertEqual(1, leftValue)

        let right: Either<Int, Int> = .right(2)
        let rightValue = await f(right)
        XCTAssertEqual(0, rightValue)
    }

    func testRightOrElse() throws {
        func f(_ either: Either<Int, Int>) -> Int? {
            either.rightOrElse { _ in 0 }
        }

        let left: Either<Int, Int> = .left(1)
        XCTAssertEqual(0, f(left))

        let right: Either<Int, Int> = .right(2)
        XCTAssertEqual(2, f(right))
    }

    func testRightOrElseAsync() async throws {
        func f(_ either: Either<Int, Int>) async -> Int? {
            let fetch: () async -> Int = { 0 }
            return await either.rightOrElse { _ in await fetch() }
        }

        let left: Either<Int, Int> = .left(1)
        let leftValue = await f(left)
        XCTAssertEqual(0, leftValue)

        let right: Either<Int, Int> = .right(2)
        let rightValue = await f(right)
        XCTAssertEqual(2, rightValue)
    }
}
