// ASCII.Code.Error.swift
// swift-ascii-primitives
//
// Typed error for ASCII.Code construction failures.

public import Byte_Primitives

extension ASCII.Code {

    /// Errors thrown when constructing an `ASCII.Code` from a byte that is
    /// not in the valid 7-bit ASCII range (0x00–0x7F).
    public enum Error: Swift.Error, Equatable, Sendable {

        /// The byte is outside the valid ASCII range.
        ///
        /// - Parameter byte: The offending byte (value >= 0x80).
        case notASCII(byte: Byte)
    }
}
