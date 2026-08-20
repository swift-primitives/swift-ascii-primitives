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
    public static func serialize<
        T: FixedWidthInteger & UnsignedInteger,
        Buffer: RangeReplaceableCollection
    >(
        _ value: T,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        if value == 0 {
            buffer.append(Byte(ASCII.Character.Graphic.`0`))
            return
        }

        // Build digits in reverse using a scratch buffer. Internal storage
        // stays UInt8 (arithmetic-domain digit calculation); bridge to Byte at
        // the append boundary.
        //
        // WHY (F-001): the scratch capacity is derived from `T.bitWidth`
        // rather than a fixed literal — a fixed 20-slot buffer (sized for
        // UInt64.max) silently overflows for any wider FixedWidthInteger
        // (e.g. UInt128, 39 digits). `T.bitWidth / 3 + 2` is a provable
        // upper bound on decimal digit count for ANY bit width: the exact
        // digit count of a bit-width-`n` unsigned max is
        // `floor(n * log10(2)) + 1`, and `log10(2) ≈ 0.30103 < 1/3`, so
        // `floor(n/3) + 2 > n * log10(2) + 1 ≥ digitCount(n)` for every
        // `n >= 0`. This holds independent of which FixedWidthInteger `T`
        // is instantiated with, so no future wider integer type can
        // reintroduce the overflow.
        var n = value
        let capacity = T.bitWidth / 3 + 2
        var count = 0

        withUnsafeTemporaryAllocation(of: UInt8.self, capacity: capacity) { scratch in
            // WHY: `capacity` is a proven upper bound (see above) on the
            // number of decimal digits `T` can ever require, so every
            // `scratch[count]` write below stays in bounds.
            while n > 0 {
                unsafe (scratch[count] = ASCII.Character.Graphic.`0` + UInt8(n % 10))
                n /= 10
                count += 1
            }
            // Append in correct order (reverse of how we built them).
            (0..<count).reversed().forEach { i in
                unsafe buffer.append(Byte(scratch[i]))
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
    public static func serialize<
        T: FixedWidthInteger & SignedInteger,
        Buffer: RangeReplaceableCollection
    >(
        _ value: T,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        if value == 0 {
            buffer.append(Byte(ASCII.Character.Graphic.`0`))
            return
        }

        // WHY (F-002): extract via `.magnitude` rather than negating `value`.
        // `T.min` (e.g. Int8.min == -128) has no positive `T` counterpart —
        // `-value` overflow-traps for every fixed-width signed `T` at its
        // minimum (confirmed: pre-fix regression run crashed with signal
        // 5/SIGTRAP on Int8.min/Int.min/Int64.min/Int128.min). `T.Magnitude`
        // is unsigned and can represent `abs(T.min)` exactly, so this path
        // is total for every `T` value, including `T.min`.
        if value < 0 {
            buffer.append(Byte(ASCII.Character.Graphic.hyphen))
        }
        var n = value.magnitude

        // Build digits in reverse using a scratch buffer. Internal storage
        // stays UInt8 (arithmetic-domain digit calculation); bridge to Byte at
        // the append boundary.
        //
        // WHY (F-001): the scratch capacity is derived from `T.bitWidth`
        // rather than a fixed literal — a fixed 20-slot buffer (sized for
        // Int64.min/.max) silently overflows for any wider FixedWidthInteger
        // (e.g. Int128, up to 39 digits). See the unsigned `serialize`
        // overload above for the `T.bitWidth / 3 + 2` bound derivation; it
        // applies unchanged here since `T.Magnitude.bitWidth == T.bitWidth`.
        let capacity = T.bitWidth / 3 + 2
        var count = 0

        withUnsafeTemporaryAllocation(of: UInt8.self, capacity: capacity) { scratch in
            // WHY: `capacity` is a proven upper bound (see above) on the
            // number of decimal digits `T.Magnitude` can ever require, so
            // every `scratch[count]` write below stays in bounds.
            while n > 0 {
                unsafe (scratch[count] = ASCII.Character.Graphic.`0` + UInt8(n % 10))
                n /= 10
                count += 1
            }
            // Append in correct order (reverse of how we built them).
            (0..<count).reversed().forEach { i in
                unsafe buffer.append(Byte(scratch[i]))
            }
        }
    }

    // Stdlib-interop UInt8 forwarder for the signed `serialize`
    // lives in `ASCII Primitives Standard Library Integration` per [API-BYTE-007].
}
