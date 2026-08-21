public import Byte_Primitives

extension ASCII.Code: Byte.`Protocol` {

    public typealias Domain = Never

    @inlinable
    public var byte: Byte { Byte(underlying) }

    @inlinable
    public init(_ byte: Byte) throws(Self.Error) {
        guard byte.underlying < 0x80 else { throw .notASCII(byte: byte) }
        self.init(byte.underlying)
    }

    @inlinable
    public init(unchecked byte: Byte) {
        self.init(byte.underlying)
    }
}

extension ASCII.Code {

    @inlinable
    public static var zero: ASCII.Code { ASCII.Code(unchecked: Byte(0x00)) }

    @inlinable
    public static var max: ASCII.Code { ASCII.Code(unchecked: Byte(0x7F)) }
}

extension ASCII.Code: ExpressibleByIntegerLiteral {

    @_disfavoredOverload
    @inlinable
    public init(integerLiteral value: UInt8.IntegerLiteralType) {
        let u = UInt8(integerLiteral: value)
        precondition(
            u < 0x80,
            "ASCII.Code integer literal must be in 0x00...0x7F (got 0x\(String(u, radix: 16)))"
        )
        self.init(unchecked: Byte(u))
    }
}

extension ASCII.Code: Equatable {}
extension ASCII.Code: Hashable {}
extension ASCII.Code: Comparable {}

extension ASCII.Code {

    @inlinable
    public static func & (lhs: ASCII.Code, rhs: ASCII.Code) -> ASCII.Code {
        ASCII.Code(unchecked: Byte(lhs.underlying & rhs.underlying))
    }

    @inlinable
    public static func | (lhs: ASCII.Code, rhs: ASCII.Code) -> ASCII.Code {
        ASCII.Code(unchecked: Byte(lhs.underlying | rhs.underlying))
    }

    @inlinable
    public static func ^ (lhs: ASCII.Code, rhs: ASCII.Code) -> ASCII.Code {
        ASCII.Code(unchecked: Byte(lhs.underlying ^ rhs.underlying))
    }

    @inlinable
    public static func &= (lhs: inout ASCII.Code, rhs: ASCII.Code) {
        lhs = lhs & rhs
    }

    @inlinable
    public static func |= (lhs: inout ASCII.Code, rhs: ASCII.Code) {
        lhs = lhs | rhs
    }

    @inlinable
    public static func ^= (lhs: inout ASCII.Code, rhs: ASCII.Code) {
        lhs = lhs ^ rhs
    }
}
