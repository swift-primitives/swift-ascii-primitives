// ASCII.Byte.swift
// swift-ascii-primitives
//
// Typed wrapper for a single ASCII byte value.

extension ASCII {

    /// A single ASCII byte value.
    ///
    /// Wraps a `UInt8` to provide typed access to ASCII classification,
    /// constants, and parsing operations. Obtained via the `UInt8.ascii`
    /// accessor.
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
    public struct Byte: Sendable {
        /// The raw byte value.
        public let rawValue: UInt8

        @_transparent
        public init(rawValue: UInt8) { self.rawValue = rawValue }
    }
}
