//
//  ASCII.Hexadecimal.swift
//  swift-ascii-primitives
//
//  Subject domain for base-16 ASCII numeral operations.
//

extension ASCII {
    /// Base-16 numeral subject domain.
    ///
    /// Extended by capability packages with concrete parser and serializer types:
    /// - `ASCII.Hexadecimal.Parser` (from `ASCII_Hexadecimal_Parser_Primitives`)
    /// - `ASCII.Hexadecimal.Serializer` (from `ASCII_Hexadecimal_Serializer_Primitives`)
    /// - `ASCII.Hexadecimal.Error` (from `ASCII_Hexadecimal_Parser_Primitives`)
    public enum Hexadecimal {}
}
