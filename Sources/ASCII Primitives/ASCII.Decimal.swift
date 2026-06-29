//
//  ASCII.Decimal.swift
//  swift-ascii-primitives
//
//  Subject domain for base-10 ASCII numeral operations.
//

extension ASCII {
    /// Base-10 numeral subject domain.
    ///
    /// Extended by capability packages with concrete parser and serializer types:
    /// - `ASCII.Decimal.Parser` (from `ASCII_Decimal_Parser_Primitives`)
    /// - `ASCII.Decimal.Serializer` (from `ASCII_Decimal_Serializer_Primitives`)
    /// - `ASCII.Decimal.Error` (from `ASCII_Decimal_Parser_Primitives`)
    public enum Decimal {}
}

// MARK: - Single Digit Serialization

extension ASCII.Decimal {
    /// Converts a decimal digit value (0-9) to its ASCII code.
    ///
    /// Inverse of `ASCII.Code.digitValue`.
    ///
    /// - Parameter value: Numeric value 0-9
    /// - Returns: ASCII code 0x30-0x39 ('0'-'9'), or nil if value > 9
    ///
    /// ## Example
    ///
    /// ```swift
    /// ASCII.Decimal.code(0)  // '0' (0x30)
    /// ASCII.Decimal.code(5)  // '5' (0x35)
    /// ASCII.Decimal.code(9)  // '9' (0x39)
    /// ASCII.Decimal.code(10) // nil
    /// ```
    @inlinable
    public static func code(_ value: UInt8) -> ASCII.Code? {
        guard value <= 9 else { return nil }
        return ASCII.Code(ASCII.Character.Graphic.`0` + value)
    }
}

// MARK: - Integer Serialization

extension ASCII.Decimal {
    /// Serialize an unsigned integer to ASCII decimal bytes.
    ///
    /// Writes the decimal representation directly to a byte buffer.
    /// This is the canonical ASCII serialization for unsigned integers.
    ///
    /// ## Example
    ///
    /// ```swift
    /// var buffer: [Byte] = []
    /// ASCII.Decimal.serialize(42, into: &buffer)
    /// // buffer is now [0x34, 0x32] ("42")
    /// ```
    ///
    /// - Parameters:
    ///   - value: The unsigned integer to serialize
    ///   - buffer: The buffer to append ASCII bytes to
    @inlinable
    public static func serialize<T: UnsignedInteger, Buffer: RangeReplaceableCollection>(
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

    // Stdlib-interop UInt8 forwarder for the unsigned `serialize`
    // lives in `ASCII Primitives Standard Library Integration` per [API-BYTE-007].

    /// Serialize a signed integer to ASCII decimal bytes.
    ///
    /// Writes the decimal representation directly to a byte buffer,
    /// including a leading '-' for negative values.
    ///
    /// ## Example
    ///
    /// ```swift
    /// var buffer: [Byte] = []
    /// ASCII.Decimal.serialize(-42, into: &buffer)
    /// // buffer is now [0x2D, 0x34, 0x32] ("-42")
    /// ```
    ///
    /// - Parameters:
    ///   - value: The signed integer to serialize
    ///   - buffer: The buffer to append ASCII bytes to
    @inlinable
    public static func serialize<T: SignedInteger, Buffer: RangeReplaceableCollection>(
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

    // Stdlib-interop UInt8 forwarder for the signed `serialize`
    // lives in `ASCII Primitives Standard Library Integration` per [API-BYTE-007].
}
