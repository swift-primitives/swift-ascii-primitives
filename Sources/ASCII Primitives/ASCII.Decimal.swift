//
//  ASCII.Decimal.swift
//  swift-ascii-primitives
//
//  Subject domain for base-10 ASCII numeral operations.
//

extension ASCII {
    /// Base-10 numeral subject domain.
    ///
    /// Extended by capability packages with concrete parser and serializer types:
    /// - `ASCII.Decimal.Parser` (from `ASCII_Decimal_Parser_Primitives`)
    /// - `ASCII.Decimal.Serializer` (from `ASCII_Decimal_Serializer_Primitives`)
    /// - `ASCII.Decimal.Error` (from `ASCII_Decimal_Parser_Primitives`)
    public enum Decimal {}
}
