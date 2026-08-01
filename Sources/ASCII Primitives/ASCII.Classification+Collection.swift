// ASCII.Classification+Collection.swift
// swift-ascii-primitives
//
// Collection-level ASCII classification predicates.
//
// Each predicate is the byte-collection equivalent of a single-byte
// predicate in `ASCII.Classification`. Empty sequences satisfy the
// `isAll*` predicates vacuously and fail the `contains*` predicates.

extension ASCII.Classification {
    /// Returns `true` if every byte in `bytes` is ASCII whitespace.
    ///
    /// Empty sequences satisfy this vacuously.
    @inlinable
    public static func isAllWhitespace<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == ASCII.Code {
        bytes.allSatisfy { Self.isWhitespace($0.underlying) }
    }

    /// Returns `true` if every byte in `bytes` is an ASCII digit.
    ///
    /// Empty sequences satisfy this vacuously.
    @inlinable
    public static func isAllDigits<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == ASCII.Code {
        bytes.allSatisfy { Self.isDigit($0.underlying) }
    }

    /// Returns `true` if every byte in `bytes` is an ASCII letter.
    ///
    /// Empty sequences satisfy this vacuously.
    @inlinable
    public static func isAllLetters<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == ASCII.Code {
        bytes.allSatisfy { Self.isLetter($0.underlying) }
    }

    /// Returns `true` if every byte in `bytes` is ASCII alphanumeric.
    ///
    /// Empty sequences satisfy this vacuously.
    @inlinable
    public static func isAllAlphanumeric<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == ASCII.Code {
        bytes.allSatisfy { Self.isAlphanumeric($0.underlying) }
    }

    /// Returns `true` if every byte in `bytes` is an ASCII control character.
    ///
    /// Empty sequences satisfy this vacuously.
    @inlinable
    public static func isAllControl<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == ASCII.Code {
        bytes.allSatisfy { Self.isControl($0.underlying) }
    }

    /// Returns `true` if every byte in `bytes` is ASCII visible (graphic
    /// excluding SPACE).
    ///
    /// Empty sequences satisfy this vacuously.
    @inlinable
    public static func isAllVisible<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == ASCII.Code {
        bytes.allSatisfy { Self.isVisible($0.underlying) }
    }

    /// Returns `true` if every byte in `bytes` is ASCII printable
    /// (graphic including SPACE).
    ///
    /// Empty sequences satisfy this vacuously.
    @inlinable
    public static func isAllPrintable<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == ASCII.Code {
        bytes.allSatisfy { Self.isPrintable($0.underlying) }
    }

    /// Returns `true` if no byte in `bytes` is an ASCII uppercase letter.
    ///
    /// Non-letter bytes are ignored.
    ///
    /// Sequences with no letters satisfy this vacuously.
    @inlinable
    public static func isAllLowercase<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == ASCII.Code {
        !bytes.contains { Self.isUppercase($0.underlying) }
    }

    /// Returns `true` if no byte in `bytes` is an ASCII lowercase letter.
    ///
    /// Non-letter bytes are ignored.
    ///
    /// Sequences with no letters satisfy this vacuously.
    @inlinable
    public static func isAllUppercase<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == ASCII.Code {
        !bytes.contains { Self.isLowercase($0.underlying) }
    }

    /// Returns `true` if any byte in `bytes` is outside the ASCII range (≥ 0x80).
    ///
    /// Returns `false` for empty sequences.
    @inlinable
    public static func containsNonASCII<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == ASCII.Code {
        bytes.contains { $0.underlying >= 0x80 }
    }

    /// Returns `true` if any byte in `bytes` is an ASCII hex digit.
    ///
    /// Returns `false` for empty sequences.
    @inlinable
    public static func containsHexDigit<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == ASCII.Code {
        bytes.contains { Self.isHexDigit($0.underlying) }
    }
}

// Stdlib-interop UInt8 forwarders for these predicates live in
// `ASCII Primitives Standard Library Integration` per [API-BYTE-007].
