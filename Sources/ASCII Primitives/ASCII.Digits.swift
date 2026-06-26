//
//  ASCII.Digits.swift
//  swift-ascii-primitives
//
//  Namespace for ASCII digit-sequence policy.
//

extension ASCII {
    /// Namespace for ASCII digit-sequence policy types.
    ///
    /// Radix-neutral: the nested policy applies identically to decimal
    /// (0x30–0x39) and hexadecimal (0–9, A–F, a–f) digit parsers.
    ///
    /// Extended by parser capability packages — `ASCII.Decimal.Parser` and
    /// `ASCII.Hexadecimal.Parser` (from `ASCII_Decimal_Parser_Primitives` and
    /// `ASCII_Hexadecimal_Parser_Primitives`) accept a ``Digits/Count`` to
    /// control how many digit bytes are consumed.
    public enum Digits {}
}
