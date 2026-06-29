// ASCII.Code+Parsing.swift
// swift-ascii-primitives
//
// Instance-level ASCII numeric parsing.

extension ASCII.Code {

    /// The decimal digit value (0-9) if this code is an ASCII digit, nil otherwise.
    ///
    /// ```swift
    /// UInt8(0x33).ascii.digitValue  // Optional(3) — character '3'
    /// UInt8(0x41).ascii.digitValue  // nil — character 'A'
    /// ```
    @inlinable
    public var digitValue: UInt8? {
        let byte = self.underlying
        guard ASCII.Classification.isDigit(byte) else { return nil }
        return byte - ASCII.Character.Graphic.`0`
    }

    /// The hex digit value (0-15) if this code is an ASCII hex digit, nil otherwise.
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
        let byte = self.underlying
        switch byte {
        case ASCII.Character.Graphic.`0`...ASCII.Character.Graphic.`9`:
            return byte - ASCII.Character.Graphic.`0`

        case ASCII.Character.Graphic.A...ASCII.Character.Graphic.F:
            return byte - ASCII.Character.Graphic.A + 10

        case ASCII.Character.Graphic.a...ASCII.Character.Graphic.f:
            return byte - ASCII.Character.Graphic.a + 10

        default:
            return nil
        }
    }
}
