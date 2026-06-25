// ASCII.Case.Conversion+UInt8.swift
//
// Stdlib-interop UInt8 forwarders for `ASCII.Case.Conversion.convert`.
// Primary byte-domain API lives in `ASCII Primitives` keyed on
// `ASCII.Code`; these forwarders bridge stdlib callers carrying
// `UInt8` / `Sequence<UInt8>` (e.g. file-read frames, network buffers)
// via `ASCII.Code.init`. Per [API-BYTE-007] (byte-discipline skill).

public import ASCII_Primitives

extension ASCII.Case.Conversion {
    /// Stdlib-interop forwarder: single-byte `UInt8 -> UInt8`.
    @_disfavoredOverload
    @_transparent
    public static func convert(_ byte: UInt8, to case: ASCII.Case) -> UInt8 {
        Self.convert(ASCII.Code(byte), to: `case`).underlying
    }
}

extension ASCII {
    /// Stdlib-interop forwarder: collection `Sequence<UInt8> -> [UInt8]`.
    @_disfavoredOverload
    @inlinable
    public static func convert<C: Swift.Collection>(
        _ bytes: C,
        to case: ASCII.Case
    ) -> [UInt8] where C.Element == UInt8 {
        Self.convert(bytes.map { Self.Code($0) }, to: `case`).map(\.underlying)
    }
}
