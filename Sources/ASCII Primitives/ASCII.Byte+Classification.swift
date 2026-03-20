// ASCII.Byte+Classification.swift
// swift-ascii-primitives
//
// Instance-level ASCII character classification.

extension ASCII.Byte {

    // MARK: - ASCII Validation

    /// Tests if this byte is valid ASCII (0x00-0x7F).
    @_transparent
    public var isASCII: Bool {
        ASCII.Validation.isASCII(rawValue)
    }

    // MARK: - Character Classification

    /// Tests if byte is ASCII whitespace (SP, HT, LF, CR).
    @_transparent
    public var isWhitespace: Bool {
        ASCII.Classification.isWhitespace(rawValue)
    }

    /// Tests if byte is ASCII control character (0x00-0x1F, 0x7F).
    @_transparent
    public var isControl: Bool {
        ASCII.Classification.isControl(rawValue)
    }

    /// Tests if byte is ASCII visible (0x21-0x7E, excludes SPACE).
    @_transparent
    public var isVisible: Bool {
        ASCII.Classification.isVisible(rawValue)
    }

    /// Tests if byte is ASCII printable (0x20-0x7E, includes SPACE).
    @_transparent
    public var isPrintable: Bool {
        ASCII.Classification.isPrintable(rawValue)
    }

    /// Tests if byte is ASCII digit ('0'...'9').
    @_transparent
    public var isDigit: Bool {
        ASCII.Classification.isDigit(rawValue)
    }

    /// Tests if byte is ASCII hexadecimal digit ('0'...'9', 'A'...'F', 'a'...'f').
    @_transparent
    public var isHexDigit: Bool {
        ASCII.Classification.isHexDigit(rawValue)
    }

    /// Tests if byte is ASCII letter ('A'...'Z' or 'a'...'z').
    @_transparent
    public var isLetter: Bool {
        ASCII.Classification.isLetter(rawValue)
    }

    /// Tests if byte is ASCII alphanumeric (digit or letter).
    @_transparent
    public var isAlphanumeric: Bool {
        ASCII.Classification.isAlphanumeric(rawValue)
    }

    /// Tests if byte is ASCII uppercase letter ('A'...'Z').
    @_transparent
    public var isUppercase: Bool {
        ASCII.Classification.isUppercase(rawValue)
    }

    /// Tests if byte is ASCII lowercase letter ('a'...'z').
    @_transparent
    public var isLowercase: Bool {
        ASCII.Classification.isLowercase(rawValue)
    }

    // MARK: - Case Conversion

    /// Returns the lowercase form of this byte (identity if not uppercase letter).
    @_transparent
    public func lowercased() -> UInt8 {
        ASCII.Case.Conversion.convert(rawValue, to: .lower)
    }

    /// Returns the uppercase form of this byte (identity if not lowercase letter).
    @_transparent
    public func uppercased() -> UInt8 {
        ASCII.Case.Conversion.convert(rawValue, to: .upper)
    }
}
