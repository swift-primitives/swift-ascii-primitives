//
//  ASCII.Binary.swift
//  swift-ascii-primitives
//
//  Subject domain for base-2 ASCII numeral operations.
//

extension ASCII {
    /// Base-2 numeral subject domain.
    ///
    /// Extended by capability packages with concrete parser and serializer types:
    /// - `ASCII.Binary.Parser` (from `ASCII_Binary_Parser_Primitives`)
    /// - `ASCII.Binary.Serializer` (from `ASCII_Binary_Serializer_Primitives`)
    /// - `ASCII.Binary.Error` (from `ASCII_Binary_Parser_Primitives`)
    public enum Binary {}
}
