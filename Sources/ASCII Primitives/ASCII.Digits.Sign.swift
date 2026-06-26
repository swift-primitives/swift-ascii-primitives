//
//  ASCII.Digits.Sign.swift
//  swift-ascii-primitives
//
//  Radix-neutral sign policy for ASCII integer parsers.
//

extension ASCII.Digits {
    /// Sign policy: whether an ASCII integer parser consumes a leading sign byte.
    ///
    /// Radix-neutral — applies identically to decimal (0x30–0x39) and
    /// hexadecimal (0–9, A–F, a–f) digit parsers. The default policy across
    /// every ASCII integer parser is ``none``, which preserves the historical
    /// no-sign behavior.
    ///
    /// ## Cases
    ///
    /// - ``none``: no sign byte is consumed.
    /// - ``optional``: an optional leading `+` (0x2B) or `-` (0x2D) is consumed.
    public enum Sign: Sendable, Equatable {
        /// Consume no sign byte (default — historical behavior).
        ///
        /// A leading `+` or `-` is left unconsumed; parsing begins at the first
        /// digit byte.
        case none
        /// Consume an optional leading sign byte.
        ///
        /// A single `+` (0x2B) selects a positive value and a single `-` (0x2D)
        /// selects a negative value; either is consumed when present. When no
        /// sign byte is present the value is positive. The digit-count policy
        /// and the at-least-one-digit requirement then apply to the digits that
        /// follow the sign.
        case optional
    }
}
