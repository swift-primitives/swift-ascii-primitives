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
    public static func isAllWhitespace<Bytes: Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == UInt8 {
        bytes.allSatisfy { ASCII.Classification.isWhitespace($0) }
    }

    /// Returns `true` if every byte in `bytes` is an ASCII digit.
    ///
    /// Empty sequences satisfy this vacuously.
    @inlinable
    public static func isAllDigits<Bytes: Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == UInt8 {
        bytes.allSatisfy { ASCII.Classification.isDigit($0) }
    }

    /// Returns `true` if every byte in `bytes` is an ASCII letter.
    ///
    /// Empty sequences satisfy this vacuously.
    @inlinable
    public static func isAllLetters<Bytes: Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == UInt8 {
        bytes.allSatisfy { ASCII.Classification.isLetter($0) }
    }

    /// Returns `true` if every byte in `bytes` is ASCII alphanumeric.
    ///
    /// Empty sequences satisfy this vacuously.
    @inlinable
    public static func isAllAlphanumeric<Bytes: Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == UInt8 {
        bytes.allSatisfy { ASCII.Classification.isAlphanumeric($0) }
    }

    /// Returns `true` if every byte in `bytes` is an ASCII control character.
    ///
    /// Empty sequences satisfy this vacuously.
    @inlinable
    public static func isAllControl<Bytes: Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == UInt8 {
        bytes.allSatisfy { ASCII.Classification.isControl($0) }
    }

    /// Returns `true` if every byte in `bytes` is ASCII visible (graphic
    /// excluding SPACE).
    ///
    /// Empty sequences satisfy this vacuously.
    @inlinable
    public static func isAllVisible<Bytes: Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == UInt8 {
        bytes.allSatisfy { ASCII.Classification.isVisible($0) }
    }

    /// Returns `true` if every byte in `bytes` is ASCII printable
    /// (graphic including SPACE).
    ///
    /// Empty sequences satisfy this vacuously.
    @inlinable
    public static func isAllPrintable<Bytes: Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == UInt8 {
        bytes.allSatisfy { ASCII.Classification.isPrintable($0) }
    }

    /// Returns `true` if no byte in `bytes` is an ASCII uppercase letter.
    /// Non-letter bytes are ignored.
    ///
    /// Sequences with no letters satisfy this vacuously.
    @inlinable
    public static func isAllLowercase<Bytes: Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == UInt8 {
        !bytes.contains { ASCII.Classification.isUppercase($0) }
    }

    /// Returns `true` if no byte in `bytes` is an ASCII lowercase letter.
    /// Non-letter bytes are ignored.
    ///
    /// Sequences with no letters satisfy this vacuously.
    @inlinable
    public static func isAllUppercase<Bytes: Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == UInt8 {
        !bytes.contains { ASCII.Classification.isLowercase($0) }
    }

    /// Returns `true` if any byte in `bytes` is outside the ASCII range (≥ 0x80).
    ///
    /// Returns `false` for empty sequences.
    @inlinable
    public static func containsNonASCII<Bytes: Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == UInt8 {
        bytes.contains { $0 >= 0x80 }
    }

    /// Returns `true` if any byte in `bytes` is an ASCII hex digit.
    ///
    /// Returns `false` for empty sequences.
    @inlinable
    public static func containsHexDigit<Bytes: Sequence>(_ bytes: Bytes) -> Bool where Bytes.Element == UInt8 {
        bytes.contains { ASCII.Classification.isHexDigit($0) }
    }
}
