// ASCII.Code.swift
// swift-ascii-primitives
//
// Typed wrapper for a single ASCII code point value, per INCITS 4-1986.
//
// Byte.`Protocol` and Carrier.`Protocol` conformances live in sibling
// files (ASCII.Code+Byte.Protocol.swift, ASCII.Code+Carrier.swift).

extension ASCII {

    /// A single code point in the ASCII (INCITS 4-1986) coding system.
    ///
    /// Wraps a `UInt8` to provide typed access to ASCII classification,
    /// constants, and parsing operations. Obtained via the `UInt8.ascii`
    /// accessor.
    ///
    /// `ASCII.Code` conforms to `Byte.\`Protocol\`` (the byte-domain
    /// capability marker from `swift-byte-primitives`) — making it a peer
    /// byte-domain conformer alongside `Byte` itself. Stdlib conformances
    /// (`Equatable`, `Hashable`, `Comparable`, `ExpressibleByIntegerLiteral`)
    /// pick up their witnesses from the `Byte.\`Protocol\`` default-impl
    /// extension.
    ///
    /// ## Usage
    ///
    /// ```swift
    /// let byte: UInt8 = 0x41
    /// byte.ascii.isLetter      // true
    /// byte.ascii.isUppercase   // true
    ///
    /// UInt8.ascii.A            // 0x41
    /// UInt8.ascii.sp           // 0x20
    /// ```
    @frozen
    public struct Code: Sendable {
        /// The underlying 7-bit code value stored in a UInt8.
        public let underlying: UInt8

        /// Creates an ASCII code wrapping the given raw `UInt8` value.
        @inlinable
        public init(_ underlying: consuming UInt8) {
            self.underlying = underlying
        }
    }
}
