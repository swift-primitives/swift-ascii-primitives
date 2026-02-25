// UInt8+ASCII.swift
// swift-ascii-primitives
//
// ASCII namespace access for UInt8.

extension UInt8 {

    /// Access to ASCII type-level constants and methods.
    ///
    /// ```swift
    /// let letterA = UInt8.ascii.A        // 0x41
    /// let space = UInt8.ascii.sp         // 0x20
    /// let tab = UInt8.ascii.htab         // 0x09
    /// ```
    public static var ascii: ASCII.Byte.Type {
        ASCII.Byte.self
    }

    /// Access to ASCII instance methods for this byte.
    ///
    /// ```swift
    /// let byte: UInt8 = 0x41
    /// byte.ascii.isLetter      // true
    /// byte.ascii.isUppercase   // true
    /// byte.ascii.hexValue      // Optional(10)
    /// ```
    public var ascii: ASCII.Byte {
        ASCII.Byte(rawValue: self)
    }
}
