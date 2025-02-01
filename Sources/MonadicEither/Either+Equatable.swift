//
//  Either+Equatable.swift
//  Monadic
//
//  Created by Pavel Annin on 25.01.2025.
//

extension Either: Equatable where Left: Equatable, Right: Equatable {
    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.left(lhs), .left(rhs)):
            return lhs == rhs

        case let (.right(lhs), .right(rhs)):
            return lhs == rhs

        default:
            return false
        }
    }

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool where Left == Right {
        lhs.take() == rhs.take()
    }

    @inline(__always)
    public static func != (lhs: Self, rhs: Self) -> Bool where Left == Right {
        !(lhs == rhs)
    }
}
