// ASCII.Line.Ending.swift
// swift-ascii-primitives
//
// ASCII line ending enumeration based on INCITS 4-1986 control characters

extension ASCII {
    /// Namespace for line-related types.
    public enum Line {}
}

extension ASCII.Line {
    /// Line ending style for ASCII text normalization.
    ///
    /// Values derive from INCITS 4-1986 ASCII character definitions:
    /// - CR: CARRIAGE RETURN (0x0D)
    /// - LF: LINE FEED (0x0A)
    ///
    /// All byte values flow from ``Control/cr`` and ``Control/lf`` constants.
    public enum Ending: Sendable {
        /// Unix style: LINE FEED (0x0A)
        case lf
        /// Old Mac style: CARRIAGE RETURN (0x0D)
        case cr
        /// Windows/Network protocol style: CARRIAGE RETURN + LINE FEED (0x0D 0x0A)
        ///
        /// Required by Internet protocols including HTTP (RFC 9112) and Email (RFC 5322).
        case crlf
    }
}
