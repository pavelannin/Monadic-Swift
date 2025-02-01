//
//  Either+String.swift
//  Monadic
//
//  Created by Pavel Annin on 26.01.2025.
//

extension Either: CustomStringConvertible where Left: CustomStringConvertible, Right: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .left(left):
            return "Either.left(\(left.description))"

        case let .right(right):
            return "Either.right(\(right.description))"
        }
    }
}

extension Either: CustomDebugStringConvertible where Left: CustomDebugStringConvertible, Right: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case let .left(left):
            return "Either.left(\(left.debugDescription))"

        case let .right(right):
            return "Either.right(\(right.debugDescription))"
        }
    }
}
