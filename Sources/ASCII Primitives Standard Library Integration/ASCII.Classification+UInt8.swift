public import ASCII_Primitives

extension ASCII.Classification {

    @_disfavoredOverload
    @inlinable
    public static func isAllWhitespace<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool
    where Bytes.Element == UInt8 {
        Self.isAllWhitespace(bytes.lazy.map { ASCII.Code($0) })
    }

    @_disfavoredOverload
    @inlinable
    public static func isAllDigits<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool
    where Bytes.Element == UInt8 {
        Self.isAllDigits(bytes.lazy.map { ASCII.Code($0) })
    }

    @_disfavoredOverload
    @inlinable
    public static func isAllLetters<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool
    where Bytes.Element == UInt8 {
        Self.isAllLetters(bytes.lazy.map { ASCII.Code($0) })
    }

    @_disfavoredOverload
    @inlinable
    public static func isAllAlphanumeric<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool
    where Bytes.Element == UInt8 {
        Self.isAllAlphanumeric(bytes.lazy.map { ASCII.Code($0) })
    }

    @_disfavoredOverload
    @inlinable
    public static func isAllControl<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool
    where Bytes.Element == UInt8 {
        Self.isAllControl(bytes.lazy.map { ASCII.Code($0) })
    }

    @_disfavoredOverload
    @inlinable
    public static func isAllVisible<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool
    where Bytes.Element == UInt8 {
        Self.isAllVisible(bytes.lazy.map { ASCII.Code($0) })
    }

    @_disfavoredOverload
    @inlinable
    public static func isAllPrintable<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool
    where Bytes.Element == UInt8 {
        Self.isAllPrintable(bytes.lazy.map { ASCII.Code($0) })
    }

    @_disfavoredOverload
    @inlinable
    public static func isAllLowercase<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool
    where Bytes.Element == UInt8 {
        Self.isAllLowercase(bytes.lazy.map { ASCII.Code($0) })
    }

    @_disfavoredOverload
    @inlinable
    public static func isAllUppercase<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool
    where Bytes.Element == UInt8 {
        Self.isAllUppercase(bytes.lazy.map { ASCII.Code($0) })
    }

    @_disfavoredOverload
    @inlinable
    public static func containsNonASCII<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool
    where Bytes.Element == UInt8 {
        Self.containsNonASCII(bytes.lazy.map { ASCII.Code($0) })
    }

    @_disfavoredOverload
    @inlinable
    public static func containsHexDigit<Bytes: Swift.Sequence>(_ bytes: Bytes) -> Bool
    where Bytes.Element == UInt8 {
        Self.containsHexDigit(bytes.lazy.map { ASCII.Code($0) })
    }
}
