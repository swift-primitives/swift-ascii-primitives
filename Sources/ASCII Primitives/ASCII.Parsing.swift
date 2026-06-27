// ASCII.Parsing.swift
// swift-ascii-primitives
//
// INCITS 4-1986 Section 4.3: Graphic Characters - Numeric Value Parsing
// Authoritative transformations from ASCII digit bytes to numeric values

extension ASCII {
    /// Numeric Value Parsing Operations.
    ///
    /// Authoritative implementations for converting ASCII digit bytes to numeric values.
    /// These are pure functions that form Galois connections between predicates and values.
    ///
    /// Per INCITS 4-1986 Table 7 (Graphic Characters):
    /// - Decimal digits: 0x30-0x39 ('0'-'9') -> 0-9
    /// - Hex digits (uppercase): 0x41-0x46 ('A'-'F') -> 10-15
    /// - Hex digits (lowercase): 0x61-0x66 ('a'-'f') -> 10-15
    public enum Parsing {}
}

extension ASCII.Parsing {
    // MARK: - Decimal Digit Parsing

    /// Parses an ASCII digit byte to its numeric value (0-9).
    ///
    /// Pure function transformation from ASCII digit to numeric value.
    /// Inverse operation of the `isDigit` predicate.
    /// Forms a Galois connection between predicates and values.
    ///
    /// Per INCITS 4-1986 Table 7:
    /// - '0' (0x30) -> 0
    /// - '1' (0x31) -> 1
    /// - ...
    /// - '9' (0x39) -> 9
    ///
    /// ## Mathematical Properties
    ///
    /// - **Partial Function**: Defined only for bytes where `isDigit(byte) == true`
    /// - **Inverse**: For valid digits, `digit + 0x30` yields the original byte
    /// - **Monotonic**: Preserves ordering of digit bytes
    ///
    /// ## Usage
    ///
    /// ```swift
    /// ASCII.Parsing.digit(0x30)  // 0 (character '0')
    /// ASCII.Parsing.digit(0x35)  // 5 (character '5')
    /// ASCII.Parsing.digit(0x39)  // 9 (character '9')
    /// ASCII.Parsing.digit(0x41)  // nil (character 'A')
    /// ```
    ///
    /// - Parameter byte: The ASCII byte to parse as a decimal digit
    /// - Returns: Numeric value 0-9 if byte is a digit, `nil` otherwise
    @inlinable
    public static func digit(_ code: ASCII.Code) -> UInt8? {
        let byte = code.underlying
        guard ASCII.Classification.isDigit(byte) else { return nil }
        return byte - ASCII.Character.Graphic.`0`
    }

    // MARK: - Hexadecimal Digit Parsing

    /// Parses an ASCII hex digit byte to its numeric value (0-15).
    ///
    /// Pure function transformation from ASCII hex digit to numeric value.
    /// Inverse operation of the `isHexDigit` predicate.
    /// Forms a Galois connection between predicates and values.
    ///
    /// Supports both uppercase and lowercase hex digits:
    /// - '0'...'9' (0x30-0x39) -> 0...9
    /// - 'A'...'F' (0x41-0x46) -> 10...15
    /// - 'a'...'f' (0x61-0x66) -> 10...15
    ///
    /// ## Mathematical Properties
    ///
    /// - **Partial Function**: Defined only for bytes where `isHexDigit(byte) == true`
    /// - **Case Insensitive**: 'A' and 'a' both map to 10
    /// - **Monotonic**: Preserves ordering within each range (digits, uppercase, lowercase)
    ///
    /// ## Usage
    ///
    /// ```swift
    /// ASCII.Parsing.hexDigit(0x30)  // 0 (character '0')
    /// ASCII.Parsing.hexDigit(0x39)  // 9 (character '9')
    /// ASCII.Parsing.hexDigit(0x41)  // 10 (character 'A')
    /// ASCII.Parsing.hexDigit(0x46)  // 15 (character 'F')
    /// ASCII.Parsing.hexDigit(0x61)  // 10 (character 'a')
    /// ASCII.Parsing.hexDigit(0x66)  // 15 (character 'f')
    /// ASCII.Parsing.hexDigit(0x47)  // nil (character 'G')
    /// ```
    ///
    /// - Parameter byte: The ASCII byte to parse as a hexadecimal digit
    /// - Returns: Numeric value 0-15 if byte is a hex digit, `nil` otherwise
    @inlinable
    public static func hexDigit(_ code: ASCII.Code) -> UInt8? {
        let byte = code.underlying
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
