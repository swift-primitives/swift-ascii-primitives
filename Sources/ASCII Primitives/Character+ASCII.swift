// Character+ASCII.swift
// swift-ascii-primitives
//
// ASCII classification and conversion for Swift.Character

extension Character {
    /// Access to ASCII type-level constants and methods.
    public static var ascii: ASCII.Type {
        ASCII.self
    }

    /// Access to ASCII instance methods for this character.
    public var ascii: ASCII {
        ASCII(character: self)
    }

    /// ASCII operations bound to a specific `Character`.
    public struct ASCII {
        /// The character these ASCII operations apply to.
        public let character: Character
    }
}

extension UInt8 {
    /// Creates a UInt8 from an ASCII Character with validation.
    ///
    /// Returns `nil` if the character is not ASCII.
    ///
    /// - Parameter character: Character to convert
    @inline(always)
    public init?(ascii character: Character) {
        guard let value = character.asciiValue else { return nil }
        self = value
    }
}

extension Character {
    /// Creates a Character from an ASCII byte with validation.
    ///
    /// Converts a UInt8 byte to a Character, returning `nil` if the byte is outside
    /// the valid US-ASCII range (0x00-0x7F).
    ///
    /// - Parameter byte: Byte value to convert to Character
    @inlinable
    public init?(ascii byte: UInt8) {
        guard byte <= 0x7F else { return nil }
        self.init(UnicodeScalar(byte))
    }
}

extension Character.ASCII {
    /// Creates a Character from an ASCII byte without validation.
    ///
    /// - Parameter byte: Byte value to convert to Character (assumed ASCII, no checking performed)
    /// - Returns: Character created from the byte
    @inlinable
    public static func unchecked(_ byte: UInt8) -> Character {
        Character(UnicodeScalar(byte))
    }

    /// Returns the character if it's valid ASCII, nil otherwise.
    @inlinable
    public func callAsFunction() -> Character? {
        character.isASCII ? character : nil
    }

    /// Converts ASCII letters to specified case.
    @inlinable
    public func callAsFunction(case: ASCII_Primitives.ASCII.Case) -> Character {
        guard let byte = UInt8(ascii: character) else { return character }
        let converted = ASCII.Case.Conversion.convert(ASCII.Code(byte), to: `case`)
        return Character(UnicodeScalar(converted.underlying))
    }

    /// Tests if character is ASCII whitespace (space, tab, LF, CR).
    @_transparent
    public var isWhitespace: Bool {
        guard let value = UInt8(ascii: character) else { return false }
        return value.ascii.isWhitespace
    }

    /// Tests if character is ASCII digit ('0'...'9').
    @_transparent
    public var isDigit: Bool {
        guard let value = UInt8(ascii: character) else { return false }
        return value.ascii.isDigit
    }

    /// Tests if character is ASCII letter ('A'...'Z' or 'a'...'z').
    @_transparent
    public var isLetter: Bool {
        guard let value = UInt8(ascii: character) else { return false }
        return value.ascii.isLetter
    }

    /// Tests if character is ASCII alphanumeric (digit or letter).
    @inlinable
    public var isAlphanumeric: Bool {
        guard let value = UInt8(ascii: character) else { return false }
        return value.ascii.isAlphanumeric
    }

    /// Tests if character is ASCII hexadecimal digit.
    @inlinable
    public var isHexDigit: Bool {
        guard let value = UInt8(ascii: character) else { return false }
        return value.ascii.isHexDigit
    }

    /// Tests if character is ASCII uppercase letter ('A'...'Z').
    @_transparent
    public var isUppercase: Bool {
        guard let value = UInt8(ascii: character) else { return false }
        return value.ascii.isUppercase
    }

    /// Tests if character is ASCII lowercase letter ('a'...'z').
    @_transparent
    public var isLowercase: Bool {
        guard let value = UInt8(ascii: character) else { return false }
        return value.ascii.isLowercase
    }
}
