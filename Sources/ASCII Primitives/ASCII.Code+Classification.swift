// ASCII.Code+Classification.swift
// swift-ascii-primitives
//
// Instance-level ASCII character classification.

extension ASCII.Code {

    // MARK: - ASCII Validation

    /// Tests if this code is valid ASCII (0x00-0x7F).
    @_transparent
    public var isASCII: Bool {
        ASCII.Validation.isASCII(underlying)
    }

    // MARK: - Character Classification

    /// Tests if code is ASCII whitespace (SP, HT, LF, CR).
    @_transparent
    public var isWhitespace: Bool {
        ASCII.Classification.isWhitespace(underlying)
    }

    /// Tests if code is ASCII control character (0x00-0x1F, 0x7F).
    @_transparent
    public var isControl: Bool {
        ASCII.Classification.isControl(underlying)
    }

    /// Tests if code is ASCII visible (0x21-0x7E, excludes SPACE).
    @_transparent
    public var isVisible: Bool {
        ASCII.Classification.isVisible(underlying)
    }

    /// Tests if code is ASCII printable (0x20-0x7E, includes SPACE).
    @_transparent
    public var isPrintable: Bool {
        ASCII.Classification.isPrintable(underlying)
    }

    /// Tests if code is an ASCII decimal digit.
    @_transparent
    public var isDigit: Bool {
        ASCII.Classification.isDigit(underlying)
    }

    /// Tests if code is an ASCII hexadecimal digit.
    @_transparent
    public var isHexDigit: Bool {
        ASCII.Classification.isHexDigit(underlying)
    }

    /// Tests if code is an ASCII letter.
    @_transparent
    public var isLetter: Bool {
        ASCII.Classification.isLetter(underlying)
    }

    /// Tests if code is ASCII alphanumeric (digit or letter).
    @_transparent
    public var isAlphanumeric: Bool {
        ASCII.Classification.isAlphanumeric(underlying)
    }

    /// Tests if code is an ASCII uppercase letter.
    @_transparent
    public var isUppercase: Bool {
        ASCII.Classification.isUppercase(underlying)
    }

    /// Tests if code is ASCII lowercase letter ('a'...'z').
    @_transparent
    public var isLowercase: Bool {
        ASCII.Classification.isLowercase(underlying)
    }

    // MARK: - Case Conversion

    /// Returns the lowercase form of this code (identity if not uppercase letter).
    @_transparent
    public func lowercased() -> ASCII.Code {
        ASCII.Case.Conversion.convert(self, to: .lower)
    }

    /// Returns the uppercase form of this code (identity if not lowercase letter).
    @_transparent
    public func uppercased() -> ASCII.Code {
        ASCII.Case.Conversion.convert(self, to: .upper)
    }
}
