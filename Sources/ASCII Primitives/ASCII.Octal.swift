//
//  ASCII.Octal.swift
//  swift-ascii-primitives
//
//  Subject domain for base-8 ASCII numeral operations.
//

extension ASCII {
    /// Base-8 numeral subject domain.
    ///
    /// Extended by capability packages with concrete parser and serializer types:
    /// - `ASCII.Octal.Parser` (from `ASCII_Octal_Parser_Primitives`)
    /// - `ASCII.Octal.Serializer` (from `ASCII_Octal_Serializer_Primitives`)
    /// - `ASCII.Octal.Error` (from `ASCII_Octal_Parser_Primitives`)
    public enum Octal {}
}
