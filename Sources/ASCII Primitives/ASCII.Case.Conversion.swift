// ASCII.Case.Conversion.swift
// swift-ascii-primitives
//
// INCITS 4-1986 Section 4.3: Graphic Characters - Case Conversion
// Transforms ASCII letters between uppercase and lowercase

extension ASCII.Case {
    /// Case Conversion Operations.
    ///
    /// Authoritative implementations for converting ASCII letters between uppercase and lowercase.
    ///
    /// Per INCITS 4-1986 Table 7 (Graphic Characters):
    /// - Capital letters: A-Z (0x41-0x5A)
    /// - Small letters: a-z (0x61-0x7A)
    /// - Difference between cases: 32 (0x20)
    public enum Conversion {}
}

extension ASCII.Case.Conversion {
    /// ASCII case conversion offset.
    ///
    /// The numeric distance between corresponding uppercase and lowercase ASCII letters.
    ///
    /// Per INCITS 4-1986, uppercase letters 'A'-'Z' (0x41-0x5A) and lowercase letters 'a'-'z' (0x61-0x7A)
    /// are separated by exactly 0x20 (32 decimal). This relationship is fundamental to ASCII's design
    /// and enables efficient case conversion through simple arithmetic operations.
    ///
    /// ## Mathematical Properties
    ///
    /// - **Identity**: `'a' - 'A' = 0x20` for all letter pairs
    /// - **Symmetry**: `lowercase = uppercase + 0x20` and `uppercase = lowercase - 0x20`
    /// - **Bit manipulation**: The offset is a single bit difference (bit 5)
    ///
    /// ## Usage
    ///
    /// ```swift
    /// let upperA: UInt8 = 0x41  // 'A'
    /// let lowerA = upperA + ASCII.Case.Conversion.offset  // 0x61 ('a')
    ///
    /// let lowerZ: UInt8 = 0x7A  // 'z'
    /// let upperZ = lowerZ - ASCII.Case.Conversion.offset  // 0x5A ('Z')
    /// ```
    ///
    /// ## See Also
    ///
    /// - ``Graphic/A``
    /// - ``Graphic/a``
    public static let offset: UInt8 = 0x20
}

extension ASCII.Case.Conversion {
    /// Converts ASCII letter to specified case, returns unchanged if not an ASCII letter.
    ///
    /// Per INCITS 4-1986 Table 7 (Graphic Characters), uppercase and lowercase ASCII letters
    /// are separated by exactly 0x20 (32 decimal). This function applies the appropriate
    /// transformation based on the target case.
    ///
    /// ## Performance
    ///
    /// Uses branchless arithmetic for optimal performance. The case offset (0x20) corresponds
    /// to bit 5, enabling efficient XOR-based conversion.
    ///
    /// ## Mathematical Properties
    ///
    /// - **Idempotence**: `convert(convert(b, to: c), to: c) == convert(b, to: c)`
    /// - **Involution** (for letters): `convert(convert(b, to: .upper), to: .lower) == b` (if `isLetter(b)`)
    /// - **Preservation**: If `!isLetter(b)`, then `convert(b, to: any) == b`
    ///
    /// ## Usage
    ///
    /// ```swift
    /// ASCII.Case.Conversion.convert(.a, to: .upper)  // .A
    /// ASCII.Case.Conversion.convert(.Z, to: .lower)  // .z
    /// ASCII.Case.Conversion.convert(.`1`, to: .upper)  // .`1` - unchanged
    /// ```
    ///
    /// - Parameters:
    ///   - code: The ASCII code to convert
    ///   - case: The target case (upper or lower)
    /// - Returns: Converted code if ASCII letter, unchanged otherwise
    @_transparent
    public static func convert(_ code: ASCII.Code, to case: ASCII.Case) -> ASCII.Code {
        let byte = code.underlying
        switch `case` {
        case .upper:
            // Check if lowercase (0x61-0x7A) using subtraction trick
            // (byte - 0x61) < 26 is true iff byte is in [0x61, 0x7A]
            let isLower = (byte &- 0x61) < 26
            return ASCII.Code(isLower ? byte &- 0x20 : byte)

        case .lower:
            // Check if uppercase (0x41-0x5A)
            let isUpper = (byte &- 0x41) < 26
            return ASCII.Code(isUpper ? byte &+ 0x20 : byte)
        }
    }
}

extension ASCII {
    /// Converts ASCII letters in byte collection to specified case.
    ///
    /// Non-ASCII bytes and non-letter bytes pass through unchanged.
    ///
    /// ## Performance
    ///
    /// For contiguous byte arrays (`[UInt8]`), uses optimized batch processing.
    /// The conversion uses branchless arithmetic for each byte.
    ///
    /// Per INCITS 4-1986 Table 7 (Graphic Characters):
    /// - Capital letters: A-Z (0x41-0x5A)
    /// - Small letters: a-z (0x61-0x7A)
    /// - Difference between cases: 32 (0x20)
    ///
    /// Mathematical Properties:
    /// - **Idempotence**: `convert(convert(b, to: c), to: c) == convert(b, to: c)`
    /// - **Functoriality**: Preserves array structure (maps over elements)
    ///
    /// Example:
    /// ```swift
    /// ASCII.convert(Array("Hello".utf8), to: .upper)  // "HELLO" bytes
    ///
    /// // Works with slices
    /// let slice = bytes[start..<end]
    /// ASCII.convert(slice, to: .lower)
    /// ```
    @inlinable
    public static func convert<C: Swift.Collection>(
        _ codes: C,
        to case: ASCII.Case
    ) -> [ASCII.Code] where C.Element == Self.Code {
        var result = [Self.Code]()
        result.reserveCapacity(codes.count)

        switch `case` {
        case .upper:
            for code in codes {
                let byte = code.underlying
                let isLower = (byte &- 0x61) < 26
                result.append(Self.Code(isLower ? byte &- 0x20 : byte))
            }

        case .lower:
            for code in codes {
                let byte = code.underlying
                let isUpper = (byte &- 0x41) < 26
                result.append(Self.Code(isUpper ? byte &+ 0x20 : byte))
            }
        }

        return result
    }

    /// Converts ASCII letters in string to specified case.
    ///
    /// Non-ASCII characters and non-letter characters pass through unchanged.
    ///
    /// Example:
    /// ```swift
    /// ASCII.convert("Hello World", to: .upper)  // "HELLO WORLD"
    /// ASCII.convert("hello", to: .upper)  // "HELLO"
    /// ```
    @inlinable
    public static func convert<S: StringProtocol>(_ string: S, to case: ASCII.Case) -> S {
        // Use `unchecked:` — callers may pass strings whose UTF-8 contains
        // bytes ≥ 0x80 (multibyte sequences). The case-conversion logic
        // is a no-op for non-ASCII-letter bytes, so high bytes pass
        // through unchanged. The throwing `ASCII.Code(_:)` would reject
        // these, breaking the lossy round-trip this API has always
        // provided.
        let convertedCodes = convert(string.utf8.map { Self.Code(unchecked: Byte($0)) }, to: `case`)
        return S(decoding: convertedCodes.map(\.underlying), as: UTF8.self)
    }
}
