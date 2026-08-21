public import ASCII_Primitives

extension ASCII.Case.Conversion {

    @_disfavoredOverload
    @_transparent
    public static func convert(_ byte: UInt8, to case: ASCII.Case) -> UInt8 {
        Self.convert(ASCII.Code(byte), to: `case`).underlying
    }
}

extension ASCII {

    @_disfavoredOverload
    @inlinable
    public static func convert<C: Swift.Collection>(
        _ bytes: C,
        to case: ASCII.Case
    ) -> [UInt8] where C.Element == UInt8 {
        Self.convert(bytes.map { Self.Code($0) }, to: `case`).map(\.underlying)
    }
}
