// ASCII.Serialization.swift
// swift-ascii-primitives
//
// INCITS 4-1986 Section 4.3: Graphic Characters - Numeric Value Serialization
// Authoritative transformations from numeric values to ASCII digit bytes

extension ASCII {
    /// Numeric Value Serialization Operations.
    ///
    /// Authoritative implementations for converting numeric values to ASCII digit bytes.
    /// These are the inverse operations of `Parsing`.
    ///
    /// Per INCITS 4-1986 Table 7 (Graphic Characters):
    /// - Decimal digits: 0-9 -> 0x30-0x39 ('0'-'9')
    /// - Hex digits (uppercase): 10-15 -> 0x41-0x46 ('A'-'F')
    /// - Hex digits (lowercase): 10-15 -> 0x61-0x66 ('a'-'f')
    ///
    /// ## Category Theory
    ///
    /// Forms an isomorphism with `Parsing`:
    /// - `serialize . parse = id` (for valid ASCII digit bytes)
    /// - `parse . serialize = id` (for valid numeric values)
    public enum Serialization {}
}

// MARK: - Single Digit Serialization

extension ASCII.Serialization {
    /// Converts a decimal digit value (0-9) to its ASCII byte.
    ///
    /// Inverse of `Parsing.digit(_:)`.
    ///
    /// - Parameter value: Numeric value 0-9
    /// - Returns: ASCII byte 0x30-0x39 ('0'-'9'), or nil if value > 9
    ///
    /// ## Example
    ///
    /// ```swift
    /// ASCII.Serialization.digit(0)  // 0x30 ('0')
    /// ASCII.Serialization.digit(5)  // 0x35 ('5')
    /// ASCII.Serialization.digit(9)  // 0x39 ('9')
    /// ASCII.Serialization.digit(10) // nil
    /// ```
    @inlinable
    public static func digit(_ value: UInt8) -> UInt8? {
        guard value <= 9 else { return nil }
        return ASCII.Character.Graphic.`0` + value
    }

    /// Converts a hex digit value (0-15) to its uppercase ASCII byte.
    ///
    /// - Parameter value: Numeric value 0-15
    /// - Returns: ASCII byte for '0'-'9' or 'A'-'F', or nil if value > 15
    @inlinable
    public static func hexDigitUppercase(_ value: UInt8) -> UInt8? {
        switch value {
        case 0...9:
            return ASCII.Character.Graphic.`0` + value

        case 10...15:
            return ASCII.Character.Graphic.A + value - 10

        default:
            return nil
        }
    }

    /// Converts a hex digit value (0-15) to its lowercase ASCII byte.
    ///
    /// - Parameter value: Numeric value 0-15
    /// - Returns: ASCII byte for '0'-'9' or 'a'-'f', or nil if value > 15
    @inlinable
    public static func hexDigitLowercase(_ value: UInt8) -> UInt8? {
        switch value {
        case 0...9:
            return ASCII.Character.Graphic.`0` + value

        case 10...15:
            return ASCII.Character.Graphic.a + value - 10

        default:
            return nil
        }
    }
}

// MARK: - Integer Serialization

extension ASCII.Serialization {
    /// Serialize an unsigned integer to ASCII decimal bytes.
    ///
    /// Writes the decimal representation directly to a byte buffer.
    /// This is the canonical ASCII serialization for unsigned integers.
    ///
    /// ## Example
    ///
    /// ```swift
    /// var buffer: [UInt8] = []
    /// ASCII.Serialization.serializeDecimal(42, into: &buffer)
    /// // buffer is now [0x34, 0x32] ("42")
    /// ```
    ///
    /// - Parameters:
    ///   - value: The unsigned integer to serialize
    ///   - buffer: The buffer to append ASCII bytes to
    @inlinable
    public static func serializeDecimal<T: UnsignedInteger, Buffer: RangeReplaceableCollection>(
        _ value: T,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        if value == 0 {
            buffer.append(Byte(ASCII.Character.Graphic.`0`))
            return
        }

        // Build digits in reverse using stack-allocated array. Internal storage
        // stays UInt8 (arithmetic-domain digit calculation); bridge to Byte at
        // the append boundary.
        // Max 20 digits for UInt64.max (18,446,744,073,709,551,615)
        var n = value
        var digits:
            (
                UInt8, UInt8, UInt8, UInt8, UInt8,
                UInt8, UInt8, UInt8, UInt8, UInt8,
                UInt8, UInt8, UInt8, UInt8, UInt8,
                UInt8, UInt8, UInt8, UInt8, UInt8
            ) = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        var count = 0

        unsafe withUnsafeMutableBytes(of: &digits) { ptr in
            // WHY: `digits` is a 20-element tuple, so its byte buffer is never
            // empty; a non-empty raw buffer always has a non-nil `baseAddress`.
            // swift-format-ignore: NeverForceUnwrap
            let base = unsafe ptr.baseAddress!.assumingMemoryBound(to: UInt8.self)
            while n > 0 {
                unsafe (base[count] = ASCII.Character.Graphic.`0` + UInt8(n % 10))
                n /= 10
                count += 1
            }
        }

        // Append in correct order (reverse of how we built them)
        unsafe withUnsafeBytes(of: &digits) { ptr in
            // WHY: `digits` is a 20-element tuple, so its byte buffer is never
            // empty; a non-empty raw buffer always has a non-nil `baseAddress`.
            // swift-format-ignore: NeverForceUnwrap
            let base = unsafe ptr.baseAddress!.assumingMemoryBound(to: UInt8.self)
            for i in (0..<count).reversed() {
                unsafe buffer.append(Byte(base[i]))
            }
        }
    }

    // Stdlib-interop UInt8 forwarder for the unsigned `serializeDecimal`
    // lives in `ASCII Primitives Standard Library Integration` per [API-BYTE-007].

    /// Serialize a signed integer to ASCII decimal bytes.
    ///
    /// Writes the decimal representation directly to a byte buffer,
    /// including a leading '-' for negative values.
    ///
    /// ## Example
    ///
    /// ```swift
    /// var buffer: [UInt8] = []
    /// ASCII.Serialization.serializeDecimal(-42, into: &buffer)
    /// // buffer is now [0x2D, 0x34, 0x32] ("-42")
    /// ```
    ///
    /// - Parameters:
    ///   - value: The signed integer to serialize
    ///   - buffer: The buffer to append ASCII bytes to
    @inlinable
    public static func serializeDecimal<T: SignedInteger, Buffer: RangeReplaceableCollection>(
        _ value: T,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        if value == 0 {
            buffer.append(Byte(ASCII.Character.Graphic.`0`))
            return
        }

        var n = value
        if n < 0 {
            buffer.append(Byte(ASCII.Character.Graphic.hyphen))
            n = -n
        }

        // Build digits in reverse using stack-allocated array. Internal storage
        // stays UInt8 (arithmetic-domain digit calculation); bridge to Byte at
        // the append boundary.
        // Max 19 digits for Int64.max (9,223,372,036,854,775,807)
        var digits:
            (
                UInt8, UInt8, UInt8, UInt8, UInt8,
                UInt8, UInt8, UInt8, UInt8, UInt8,
                UInt8, UInt8, UInt8, UInt8, UInt8,
                UInt8, UInt8, UInt8, UInt8, UInt8
            ) = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        var count = 0

        unsafe withUnsafeMutableBytes(of: &digits) { ptr in
            // WHY: `digits` is a 20-element tuple, so its byte buffer is never
            // empty; a non-empty raw buffer always has a non-nil `baseAddress`.
            // swift-format-ignore: NeverForceUnwrap
            let base = unsafe ptr.baseAddress!.assumingMemoryBound(to: UInt8.self)
            while n > 0 {
                unsafe (base[count] = ASCII.Character.Graphic.`0` + UInt8(n % 10))
                n /= 10
                count += 1
            }
        }

        // Append in correct order (reverse of how we built them)
        unsafe withUnsafeBytes(of: &digits) { ptr in
            // WHY: `digits` is a 20-element tuple, so its byte buffer is never
            // empty; a non-empty raw buffer always has a non-nil `baseAddress`.
            // swift-format-ignore: NeverForceUnwrap
            let base = unsafe ptr.baseAddress!.assumingMemoryBound(to: UInt8.self)
            for i in (0..<count).reversed() {
                unsafe buffer.append(Byte(base[i]))
            }
        }
    }

    // Stdlib-interop UInt8 forwarder for the signed `serializeDecimal`
    // lives in `ASCII Primitives Standard Library Integration` per [API-BYTE-007].
}
