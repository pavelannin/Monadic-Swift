//
//  Either+Codable.swift
//  Monadic
//
//  Created by Pavel Annin on 25.01.2025.
//

private extension Either {
    enum CodingKey: String, Swift.CodingKey {
        case left
        case right
    }
}


// MARK: - Decodable
extension Either: Encodable where Left: Encodable, Right: Encodable {
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKey.self)

        switch self {
        case let .left(left):
            try container.encode(left, forKey: .left)

        case let .right(right):
            try container.encode(right, forKey: .right)
        }
    }
}

// MARK: - Decodable
extension Either: Decodable where Left: Decodable, Right: Decodable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKey.self)

        if let left = try container.decodeIfPresent(Left.self, forKey: .left) {
            self = .left(left)
        } else if let right = try container.decodeIfPresent(Right.self, forKey: .right) {
            self = .right(right)
        } else {
            throw NeitherLeftNorRightValueWasEncoded()
        }
    }

    public struct NeitherLeftNorRightValueWasEncoded: Error {}
}
