//
//  ASCII.Hexadecimal.swift
//  swift-ascii-primitives
//
//  Subject domain for base-16 ASCII numeral operations.
//

extension ASCII {
    /// Base-16 numeral subject domain.
    ///
    /// Extended by capability packages with concrete parser and serializer types:
    /// - `ASCII.Hexadecimal.Parser` (from `ASCII_Hexadecimal_Parser_Primitives`)
    /// - `ASCII.Hexadecimal.Serializer` (from `ASCII_Hexadecimal_Serializer_Primitives`)
    /// - `ASCII.Hexadecimal.Error` (from `ASCII_Hexadecimal_Parser_Primitives`)
    public enum Hexadecimal {}
}

// MARK: - Single Digit Serialization

extension ASCII.Hexadecimal {
    /// Converts a hex digit value (0-15) to its ASCII code.
    ///
    /// Inverse of `ASCII.Code.hexValue`. Takes the numeric `value` (0-15) and
    /// the letter `case` for digits 10-15 (default `.upper`). Digits 0-9 map
    /// to '0'-'9' regardless of `case`; values 10-15 map to 'A'-'F' (`.upper`)
    /// or 'a'-'f' (`.lower`).
    ///
    /// - Returns: ASCII code for '0'-'9' or 'A'-'F' / 'a'-'f', or nil for out-of-range input
    ///
    /// ## Example
    ///
    /// ```swift
    /// ASCII.Hexadecimal.code(10)              // 'A' (0x41)
    /// ASCII.Hexadecimal.code(10, case: .lower) // 'a' (0x61)
    /// ASCII.Hexadecimal.code(15)              // 'F' (0x46)
    /// ASCII.Hexadecimal.code(16)              // nil
    /// ```
    @inlinable
    public static func code(_ value: UInt8, `case`: ASCII.Case = .upper) -> ASCII.Code? {
        switch value {
        case 0...9:
            return ASCII.Code(ASCII.Character.Graphic.`0` + value)

        case 10...15:
            switch `case` {
            case .upper:
                return ASCII.Code(ASCII.Character.Graphic.A + value - 10)

            case .lower:
                return ASCII.Code(ASCII.Character.Graphic.a + value - 10)
            }

        default:
            return nil
        }
    }
}
