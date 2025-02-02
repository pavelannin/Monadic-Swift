//
//  LCE+Equtable.swift
//  Monadic
//
//  Created by Pavel Annin on 02.02.2025.
//

extension LCE: Equatable where Loading: Equatable, Content: Equatable, Failure: Equatable {
    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.loading(lhs), .loading(rhs)):
            return lhs == rhs

        case let (.content(lhs), .content(rhs)):
            return lhs == rhs

        case let (.error(lhs), .error(rhs)):
            return lhs == rhs

        default:
            return false
        }
    }
}
