// ASCII.Byte+Parsing.swift
// swift-ascii-primitives
//
// Instance-level ASCII numeric parsing.

extension ASCII.Byte {

    /// The decimal digit value (0-9) if this byte is an ASCII digit, nil otherwise.
    ///
    /// ```swift
    /// UInt8(0x33).ascii.digitValue  // Optional(3) — character '3'
    /// UInt8(0x41).ascii.digitValue  // nil — character 'A'
    /// ```
    @inlinable
    public var digitValue: UInt8? {
        ASCII.Parsing.digit(rawValue)
    }

    /// The hex digit value (0-15) if this byte is an ASCII hex digit, nil otherwise.
    ///
    /// Supports both uppercase and lowercase:
    /// - '0'...'9' → 0...9
    /// - 'A'...'F' → 10...15
    /// - 'a'...'f' → 10...15
    ///
    /// ```swift
    /// UInt8(0x46).ascii.hexValue  // Optional(15) — character 'F'
    /// UInt8(0x61).ascii.hexValue  // Optional(10) — character 'a'
    /// UInt8(0x47).ascii.hexValue  // nil — character 'G'
    /// ```
    @inlinable
    public var hexValue: UInt8? {
        ASCII.Parsing.hexDigit(rawValue)
    }
}
