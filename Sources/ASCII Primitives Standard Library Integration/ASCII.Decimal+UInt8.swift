// ASCII.Decimal+UInt8.swift
//
// Stdlib-interop UInt8 forwarders for `ASCII.Decimal.serialize`. Primary
// byte-domain API lives in `ASCII Primitives` keyed on `Byte`; these
// forwarders bridge stdlib callers carrying `RangeReplaceableCollection`
// whose `Element == UInt8` (e.g. `[UInt8]`, `ContiguousArray<UInt8>`)
// by serializing into a temporary `[Byte]` and then unwrapping via
// `.underlying`. Per [API-BYTE-007] (byte-discipline skill).

public import ASCII_Primitives
internal import Byte_Primitives

extension ASCII.Decimal {
    /// Stdlib-interop forwarder: `Buffer.Element == UInt8`.
    @_disfavoredOverload
    @inlinable
    public static func serialize<
        T: FixedWidthInteger & UnsignedInteger,
        Buffer: RangeReplaceableCollection
    >(
        _ value: T,
        into buffer: inout Buffer
    ) where Buffer.Element == UInt8 {
        var typed: [Byte] = []
        Self.serialize(value, into: &typed)
        buffer.append(contentsOf: typed.underlying)
    }

    /// Stdlib-interop forwarder: `Buffer.Element == UInt8`.
    @_disfavoredOverload
    @inlinable
    public static func serialize<
        T: FixedWidthInteger & SignedInteger,
        Buffer: RangeReplaceableCollection
    >(
        _ value: T,
        into buffer: inout Buffer
    ) where Buffer.Element == UInt8 {
        var typed: [Byte] = []
        Self.serialize(value, into: &typed)
        buffer.append(contentsOf: typed.underlying)
    }
}
