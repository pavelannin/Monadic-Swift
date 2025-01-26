//
//  Either+Comparable.swift
//  Monadic
//
//  Created by Pavel Annin on 25.01.2025.
//

extension Either: Comparable where Left: Comparable, Right: Comparable {
    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.left(lhs), .left(rhs)):
            return lhs < rhs

        case let (.right(lhs), .right(rhs)):
            return lhs < rhs

        default:
            return false
        }
    }


    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool where Left == Right {
        lhs.take() < rhs.take()
    }
}
