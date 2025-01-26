//
//  Either+Hashable.swift
//  Monadic
//
//  Created by Pavel Annin on 26.01.2025.
//

extension Either: Hashable where Left: Hashable, Right: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .left(left):
            left.hash(into: &hasher)

        case let .right(right):
            right.hash(into: &hasher)
        }
    }
}
