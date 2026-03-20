// ASCII.swift
// swift-ascii-primitives
//
// ASCII Primitives - Tier 0 zero-dependency implementation
// Based on INCITS 4-1986 (R2022): 7-Bit American Standard Code for Information Interchange

/// ASCII: American Standard Code for Information Interchange
///
/// Authoritative namespace for all US-ASCII definitions and operations.
///
/// ## Overview
///
/// This type serves as the canonical implementation of ASCII character definitions
/// per INCITS 4-1986 (R2022). All ASCII-related operations and constants throughout
/// Swift Institute libraries reference the definitions contained within this namespace,
/// ensuring consistency and standards compliance.
///
/// ## Character Set Structure
///
/// US-ASCII defines a 7-bit character encoding (0x00-0x7F, decimal 0-127) consisting of:
/// - **Control Characters** (0x00-0x1F, 0x7F): 33 non-printing characters for device control and formatting
/// - **Graphic Characters** (0x20-0x7E): 95 printable characters including letters, digits, and symbols
/// - **SPACE** (0x20): Special character with dual interpretation as both graphic and control
///
/// ## Nested Namespaces
///
/// The standard's structure is reflected in nested type namespaces:
/// - ``Control``: All 33 control characters (NUL, SOH, STX, ..., DEL)
/// - ``Graphic``: 94 printable characters (letters, digits, punctuation)
/// - ``SPACE``: The space character (0x20) with its dual nature
///
/// ## Usage
///
/// ```swift
/// // Access control characters
/// let lineFeed = ASCII.Control.lf
/// let carriageReturn = ASCII.Control.cr
///
/// // Access graphic characters
/// let letterA = ASCII.Graphic.A
/// let digit0 = ASCII.Graphic.zero
///
/// // Use common constants
/// let whitespace = ASCII.whitespaces
/// let lineEnding = ASCII.Control.crlf
/// ```
///
/// ## See Also
///
/// - ``Control``
/// - ``Graphic``
/// - ``SPACE``
/// - ``whitespaces``
/// - ``Case.Conversion/offset``
public enum ASCII {}

extension ASCII {
    /// ASCII Letter Case
    ///
    /// Per INCITS 4-1986 Table 7, ASCII letters exist in two cases:
    /// - Capital letters: A-Z (0x41-0x5A)
    /// - Small letters: a-z (0x61-0x7A)
    public enum Case: Sendable {
        /// Uppercase (capital letters A-Z)
        case upper
        /// Lowercase (small letters a-z)
        case lower
    }
}

extension ASCII {
    /// Canonical definition of ASCII whitespace bytes
    ///
    /// Single source of truth for ASCII whitespace per INCITS 4-1986.
    /// Contains exactly four characters:
    /// - 0x20 (SPACE) - Word separator
    /// - 0x09 (HORIZONTAL TAB) - Tabulation
    /// - 0x0A (LINE FEED) - End of line (Unix/macOS)
    /// - 0x0D (CARRIAGE RETURN) - End of line (Internet standards, classic Mac)
    ///
    /// ## Rationale
    ///
    /// These are the only four whitespace characters defined in the 7-bit US-ASCII standard.
    /// This differs from Unicode, which defines additional whitespace characters (e.g., non-breaking space,
    /// various width spaces) that are outside the ASCII range.
    ///
    /// ## Usage
    ///
    /// ```swift
    /// let byte: UInt8 = 0x20
    /// if ASCII.whitespaces.contains(byte) {
    ///     print("Is whitespace")
    /// }
    /// ```
    ///
    /// ## See Also
    ///
    /// - ``SPACE``
    /// - ``Control/htab``
    /// - ``Control/lf``
    /// - ``Control/cr``
    public static let whitespaces: Set<UInt8> = [
        SPACE.sp,
        Control.htab,
        Control.lf,
        Control.cr,
    ]
}
