import XCTest
import MonadicMonadsEither
import MonadicEither
import MonadicLCE
import MonadicResult

@MainActor
final class SendableTests: XCTestCase {
    func testEitherCanCrossActorBoundary() async {
        let relay = Relay()
        let left: MonadicEither.Either<String, Int> = .left("error")
        let right: MonadicEither.Either<String, Int> = .right(42)
        let receivedLeft = await relay.echo(left)
        let receivedRight = await relay.echo(right)
        XCTAssertEqual(receivedLeft, left)
        XCTAssertEqual(receivedRight, right)
    }

    func testLegacyEitherCanCrossActorBoundary() async {
        let relay = Relay()
        let left: MonadicMonadsEither.Either<String, Int> = .left("error")
        let right: MonadicMonadsEither.Either<String, Int> = .right(42)
        let receivedLeft = await relay.echo(left)
        let receivedRight = await relay.echo(right)
        XCTAssertEqual(receivedLeft, left)
        XCTAssertEqual(receivedRight, right)
    }

    func testLCECanCrossActorBoundary() async {
        let relay = Relay()
        let values: [LCE<Int, String, String>] = [.loading(1), .content("value"), .error("error")]
        for value in values {
            let received = await relay.echo(value)
            switch (value, received) {
            case let (.loading(expected), .loading(actual)):
                XCTAssertEqual(actual, expected)
            case let (.content(expected), .content(actual)), let (.error(expected), .error(actual)):
                XCTAssertEqual(actual, expected)
            default:
                XCTFail("Передача между акторами должна сохранять вариант LCE")
            }
        }
    }

    func testResultUsesStandardLibrarySendableConformance() async {
        let relay = Relay()
        let value: Result<Int, TestError> = .success(42)
        let received = await relay.echo(value)
        XCTAssertEqual(received, value)
    }

    func testNonSendablePayloadsRemainAvailableLocally() {
        let payload = LocalPayload()
        let either: MonadicEither.Either<String, LocalPayload> = .right(payload)
        let legacy: MonadicMonadsEither.Either<String, LocalPayload> = .right(payload)
        let lce: LCE<Void, LocalPayload, String> = .content(payload)
        guard case let .right(eitherPayload) = either,
              case let .right(legacyPayload) = legacy,
              case let .content(lcePayload) = lce else {
            return XCTFail("Модели должны поддерживать локальные payload без Sendable")
        }
        XCTAssertTrue(eitherPayload === payload)
        XCTAssertTrue(legacyPayload === payload)
        XCTAssertTrue(lcePayload === payload)
    }

    func testCatchingInitializersPreserveTypedErrors() async {
        let sync = MonadicEither.Either<TestError, Int>(catching: { () throws(TestError) in
            throw .failed
        })
        let async = await MonadicEither.Either<TestError, Int>(catching: { @Sendable () async throws(TestError) in
            throw .failed
        })
        XCTAssertEqual(sync, .left(.failed))
        XCTAssertEqual(async, .left(.failed))
    }
}

private actor Relay {
    func echo<Value: Sendable>(_ value: Value) -> Value { value }
}

private final class LocalPayload {
    var value = 0
}

private enum TestError: Error {
    case failed
}
