//
//  EitherTest+On.swift
//  Monadic
//
//  Created by Pavel Annin on 27.01.2025.
//

import XCTest
@testable import Either

final class EitherOnTests: XCTestCase {
    func testOnLeft() {
        func f(_ either: Either<Int, Int>) {
            let _ = either.onLeft { value in XCTAssertEqual(1, value) }
        }

        let left: Either<Int, Int> = .left(1)
        f(left)

        let right: Either<Int, Int> = .right(2)
        f(right)
    }

    func testOnLeftAsync() async {
        func f(_ either: Either<Int, Int>) async {
            let check: (Int) async -> Void = { value in XCTAssertEqual(1, value) }
            let _ = await either.onLeft(check)
        }

        let left: Either<Int, Int> = .left(1)
        await f(left)

        let right: Either<Int, Int> = .right(2)
        await f(right)
    }

    func testOnRight() {
        func f(_ either: Either<Int, Int>) {
            let _ = either.onRight { value in XCTAssertEqual(2, value) }
        }

        let left: Either<Int, Int> = .left(1)
        f(left)

        let right: Either<Int, Int> = .right(2)
        f(right)
    }

    func testOnRightAsync() async {
        func f(_ either: Either<Int, Int>) async {
            let check: (Int) async -> Void = { value in XCTAssertEqual(2, value) }
            let _ = await either.onRight(check)
        }

        let left: Either<Int, Int> = .left(1)
        await f(left)

        let right: Either<Int, Int> = .right(2)
        await f(right)
    }
}
