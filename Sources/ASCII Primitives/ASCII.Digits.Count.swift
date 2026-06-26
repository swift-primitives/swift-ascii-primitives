//
//  ASCII.Digits.Count.swift
//  swift-ascii-primitives
//
//  Radix-neutral digit-count policy for ASCII integer parsers.
//

extension ASCII.Digits {
    /// Digit-count policy: how many ASCII digit bytes a parser consumes.
    ///
    /// Radix-neutral — applies identically to decimal (0x30–0x39) and
    /// hexadecimal (0–9, A–F, a–f) digit parsers. The default policy across
    /// every ASCII integer parser is ``greedy``, which preserves the historical
    /// consume-all-available behavior.
    ///
    /// ## Cases
    ///
    /// - ``greedy``: consume every available digit byte (at least one required).
    /// - ``exactly(_:)``: consume exactly `n` digit bytes — needed by
    ///   fixed-width fields such as the `YYYY`, `MM`, and `DD` components of an
    ///   ISO 8601 date.
    /// - ``atMost(_:)``: consume greedily but stop after at most `n` digit bytes.
    public enum Count: Sendable, Equatable {
        /// Consume every available digit byte; requires at least one.
        case greedy
        /// Consume exactly `n` digit bytes.
        ///
        /// Fewer than `n` digit bytes available before a non-digit byte or the
        /// end of input is a shortfall failure; a further digit beyond `n` is
        /// left unconsumed. The degenerate `exactly(0)` policy always fails.
        case exactly(Int)
        /// Consume greedily, capped at `n` digit bytes; requires at least one.
        case atMost(Int)
    }
}
