// ASCII.Code+Constants.swift
// swift-ascii-primitives
//
// Self-typed static ASCII character constants on ASCII.Code.
//
// Per the ASCII-domain retyping arc (2026-05-19) reframing: constants
// return Self (ASCII.Code) with inlined literal values, no delegation.
// L1 stays spec-agnostic at the constants layer; ASCII.Character.Graphic
// and ASCII.Character.Control remain in this package as the spec-mirroring
// documentation artifact (S5 HYBRID-defer; standalone-arc L2 relocation
// queued at workspace root).
//
// ASCII.Code conforms to Byte.`Protocol`, Carrier.`Protocol` (Underlying
// = UInt8), Equatable, Hashable, Comparable, ExpressibleByIntegerLiteral
// — comparison + arithmetic in ASCII-substrate consumer code works at
// the typed level without back-compat UInt8 forwarding. The Byte.Protocol
// default-impl witnesses (incl. init(integerLiteral:)) require Byte_Primitives
// visible at member-import resolution per #MemberImportVisibility.

internal import Byte_Primitives

// MARK: - Control Characters (0x00-0x1F, 0x7F)

extension ASCII.Code {

    /// NULL character (0x00).
    public static var nul: ASCII.Code { ASCII.Code(0x00) }

    /// START OF HEADING (0x01).
    public static var soh: ASCII.Code { ASCII.Code(0x01) }

    /// START OF TEXT (0x02).
    public static var stx: ASCII.Code { ASCII.Code(0x02) }

    /// END OF TEXT (0x03).
    public static var etx: ASCII.Code { ASCII.Code(0x03) }

    /// END OF TRANSMISSION (0x04).
    public static var eot: ASCII.Code { ASCII.Code(0x04) }

    /// ENQUIRY (0x05).
    public static var enq: ASCII.Code { ASCII.Code(0x05) }

    /// ACKNOWLEDGE (0x06).
    public static var ack: ASCII.Code { ASCII.Code(0x06) }

    /// BELL (0x07).
    public static var bel: ASCII.Code { ASCII.Code(0x07) }

    /// BACKSPACE (0x08).
    public static var bs: ASCII.Code { ASCII.Code(0x08) }

    /// HORIZONTAL TAB (0x09).
    public static var htab: ASCII.Code { ASCII.Code(0x09) }
    /// Alias for ``htab``.
    public static var tab: ASCII.Code { ASCII.Code(0x09) }

    /// LINE FEED (0x0A).
    public static var lf: ASCII.Code { ASCII.Code(0x0A) }
    /// Alias for ``lf``.
    public static var newline: ASCII.Code { ASCII.Code(0x0A) }

    /// VERTICAL TAB (0x0B).
    public static var vtab: ASCII.Code { ASCII.Code(0x0B) }

    /// FORM FEED (0x0C).
    public static var ff: ASCII.Code { ASCII.Code(0x0C) }

    /// CARRIAGE RETURN (0x0D).
    public static var cr: ASCII.Code { ASCII.Code(0x0D) }

    /// SHIFT OUT (0x0E).
    public static var so: ASCII.Code { ASCII.Code(0x0E) }

    /// SHIFT IN (0x0F).
    public static var si: ASCII.Code { ASCII.Code(0x0F) }

    /// DATA LINK ESCAPE (0x10).
    public static var dle: ASCII.Code { ASCII.Code(0x10) }

    /// DEVICE CONTROL ONE (0x11).
    public static var dc1: ASCII.Code { ASCII.Code(0x11) }

    /// DEVICE CONTROL TWO (0x12).
    public static var dc2: ASCII.Code { ASCII.Code(0x12) }

    /// DEVICE CONTROL THREE (0x13).
    public static var dc3: ASCII.Code { ASCII.Code(0x13) }

    /// DEVICE CONTROL FOUR (0x14).
    public static var dc4: ASCII.Code { ASCII.Code(0x14) }

    /// NEGATIVE ACKNOWLEDGE (0x15).
    public static var nak: ASCII.Code { ASCII.Code(0x15) }

    /// SYNCHRONOUS IDLE (0x16).
    public static var syn: ASCII.Code { ASCII.Code(0x16) }

    /// END OF TRANSMISSION BLOCK (0x17).
    public static var etb: ASCII.Code { ASCII.Code(0x17) }

    /// CANCEL (0x18).
    public static var can: ASCII.Code { ASCII.Code(0x18) }

    /// END OF MEDIUM (0x19).
    public static var em: ASCII.Code { ASCII.Code(0x19) }

    /// SUBSTITUTE (0x1A).
    public static var sub: ASCII.Code { ASCII.Code(0x1A) }

    /// ESCAPE (0x1B).
    public static var esc: ASCII.Code { ASCII.Code(0x1B) }

    /// FILE SEPARATOR (0x1C).
    public static var fs: ASCII.Code { ASCII.Code(0x1C) }

    /// GROUP SEPARATOR (0x1D).
    public static var gs: ASCII.Code { ASCII.Code(0x1D) }

    /// RECORD SEPARATOR (0x1E).
    public static var rs: ASCII.Code { ASCII.Code(0x1E) }

    /// UNIT SEPARATOR (0x1F).
    public static var us: ASCII.Code { ASCII.Code(0x1F) }

    /// DELETE (0x7F).
    public static var del: ASCII.Code { ASCII.Code(0x7F) }
}

// MARK: - SPACE (0x20)

extension ASCII.Code {

    /// SPACE (0x20).
    public static var sp: ASCII.Code { ASCII.Code(0x20) }
    /// Alias for ``sp``.
    public static var space: ASCII.Code { ASCII.Code(0x20) }
}

// MARK: - Graphic Characters — Punctuation (0x21-0x2F)

extension ASCII.Code {

    /// EXCLAMATION POINT (0x21), the `!` character.
    public static var exclamationPoint: ASCII.Code { ASCII.Code(0x21) }
    /// Alias for ``exclamationPoint``.
    public static var exclamationMark: ASCII.Code { ASCII.Code(0x21) }

    /// QUOTATION MARK (0x22), the double-quote character.
    public static var quotationMark: ASCII.Code { ASCII.Code(0x22) }
    /// Alias for ``quotationMark``.
    public static var dquote: ASCII.Code { ASCII.Code(0x22) }
    /// Alias for ``quotationMark``.
    public static var doubleQuote: ASCII.Code { ASCII.Code(0x22) }

    /// NUMBER SIGN (0x23) - #.
    public static var numberSign: ASCII.Code { ASCII.Code(0x23) }

    /// DOLLAR SIGN (0x24) - $.
    public static var dollarSign: ASCII.Code { ASCII.Code(0x24) }

    /// PERCENT SIGN (0x25) - %.
    public static var percentSign: ASCII.Code { ASCII.Code(0x25) }

    /// AMPERSAND (0x26) - &.
    public static var ampersand: ASCII.Code { ASCII.Code(0x26) }

    /// APOSTROPHE (0x27), the single-quote character.
    public static var apostrophe: ASCII.Code { ASCII.Code(0x27) }

    /// LEFT PARENTHESIS (0x28) - (.
    public static var leftParenthesis: ASCII.Code { ASCII.Code(0x28) }

    /// RIGHT PARENTHESIS (0x29) - ).
    public static var rightParenthesis: ASCII.Code { ASCII.Code(0x29) }

    /// ASTERISK (0x2A) - *.
    public static var asterisk: ASCII.Code { ASCII.Code(0x2A) }

    /// PLUS SIGN (0x2B) - +.
    public static var plusSign: ASCII.Code { ASCII.Code(0x2B) }
    /// Alias for ``plusSign``.
    public static var plus: ASCII.Code { ASCII.Code(0x2B) }

    /// COMMA (0x2C) - ,.
    public static var comma: ASCII.Code { ASCII.Code(0x2C) }

    /// HYPHEN, MINUS SIGN (0x2D) - -.
    public static var hyphen: ASCII.Code { ASCII.Code(0x2D) }

    /// PERIOD, DECIMAL POINT (0x2E) - .
    public static var period: ASCII.Code { ASCII.Code(0x2E) }

    /// SLANT (SOLIDUS) (0x2F) - /.
    public static var slant: ASCII.Code { ASCII.Code(0x2F) }
    /// Alias for ``slant``.
    public static var solidus: ASCII.Code { ASCII.Code(0x2F) }
    /// Alias for ``slant``.
    public static var slash: ASCII.Code { ASCII.Code(0x2F) }
    /// Alias for ``slant``.
    public static var forwardSlash: ASCII.Code { ASCII.Code(0x2F) }
}

// MARK: - Graphic Characters — Digits (0x30-0x39)

extension ASCII.Code {

    /// DIGIT ZERO (0x30) - 0.
    public static var `0`: ASCII.Code { ASCII.Code(0x30) }

    /// DIGIT ONE (0x31) - 1.
    public static var `1`: ASCII.Code { ASCII.Code(0x31) }

    /// DIGIT TWO (0x32) - 2.
    public static var `2`: ASCII.Code { ASCII.Code(0x32) }

    /// DIGIT THREE (0x33) - 3.
    public static var `3`: ASCII.Code { ASCII.Code(0x33) }

    /// DIGIT FOUR (0x34) - 4.
    public static var `4`: ASCII.Code { ASCII.Code(0x34) }

    /// DIGIT FIVE (0x35) - 5.
    public static var `5`: ASCII.Code { ASCII.Code(0x35) }

    /// DIGIT SIX (0x36) - 6.
    public static var `6`: ASCII.Code { ASCII.Code(0x36) }

    /// DIGIT SEVEN (0x37) - 7.
    public static var `7`: ASCII.Code { ASCII.Code(0x37) }

    /// DIGIT EIGHT (0x38) - 8.
    public static var `8`: ASCII.Code { ASCII.Code(0x38) }

    /// DIGIT NINE (0x39) - 9.
    public static var `9`: ASCII.Code { ASCII.Code(0x39) }
}

// MARK: - Graphic Characters — More Punctuation (0x3A-0x40)

extension ASCII.Code {

    /// COLON (0x3A) - :.
    public static var colon: ASCII.Code { ASCII.Code(0x3A) }

    /// SEMICOLON (0x3B) - ;.
    public static var semicolon: ASCII.Code { ASCII.Code(0x3B) }

    /// LESS-THAN SIGN (0x3C) - <.
    public static var lessThanSign: ASCII.Code { ASCII.Code(0x3C) }
    /// Alias for ``lessThanSign``.
    public static var lt: ASCII.Code { ASCII.Code(0x3C) }
    /// Alias for ``lessThanSign``.
    public static var lessThan: ASCII.Code { ASCII.Code(0x3C) }

    /// EQUALS SIGN (0x3D) - =.
    public static var equalsSign: ASCII.Code { ASCII.Code(0x3D) }

    /// GREATER-THAN SIGN (0x3E) - >.
    public static var greaterThanSign: ASCII.Code { ASCII.Code(0x3E) }
    /// Alias for ``greaterThanSign``.
    public static var gt: ASCII.Code { ASCII.Code(0x3E) }
    /// Alias for ``greaterThanSign``.
    public static var greaterThan: ASCII.Code { ASCII.Code(0x3E) }

    /// QUESTION MARK (0x3F) - ?.
    public static var questionMark: ASCII.Code { ASCII.Code(0x3F) }

    /// COMMERCIAL AT (0x40) - @.
    public static var commercialAt: ASCII.Code { ASCII.Code(0x40) }
    /// Alias for ``commercialAt``.
    public static var at: ASCII.Code { ASCII.Code(0x40) }
    /// Alias for ``commercialAt``.
    public static var atSign: ASCII.Code { ASCII.Code(0x40) }
}

// MARK: - Graphic Characters — Uppercase Letters (0x41-0x5A)

extension ASCII.Code {

    /// CAPITAL LETTER A (0x41).
    public static var A: ASCII.Code { ASCII.Code(0x41) }

    /// CAPITAL LETTER B (0x42).
    public static var B: ASCII.Code { ASCII.Code(0x42) }

    /// CAPITAL LETTER C (0x43).
    public static var C: ASCII.Code { ASCII.Code(0x43) }

    /// CAPITAL LETTER D (0x44).
    public static var D: ASCII.Code { ASCII.Code(0x44) }

    /// CAPITAL LETTER E (0x45).
    public static var E: ASCII.Code { ASCII.Code(0x45) }

    /// CAPITAL LETTER F (0x46).
    public static var F: ASCII.Code { ASCII.Code(0x46) }

    /// CAPITAL LETTER G (0x47).
    public static var G: ASCII.Code { ASCII.Code(0x47) }

    /// CAPITAL LETTER H (0x48).
    public static var H: ASCII.Code { ASCII.Code(0x48) }

    /// CAPITAL LETTER I (0x49).
    public static var I: ASCII.Code { ASCII.Code(0x49) }

    /// CAPITAL LETTER J (0x4A).
    public static var J: ASCII.Code { ASCII.Code(0x4A) }

    /// CAPITAL LETTER K (0x4B).
    public static var K: ASCII.Code { ASCII.Code(0x4B) }

    /// CAPITAL LETTER L (0x4C).
    public static var L: ASCII.Code { ASCII.Code(0x4C) }

    /// CAPITAL LETTER M (0x4D).
    public static var M: ASCII.Code { ASCII.Code(0x4D) }

    /// CAPITAL LETTER N (0x4E).
    public static var N: ASCII.Code { ASCII.Code(0x4E) }

    /// CAPITAL LETTER O (0x4F).
    public static var O: ASCII.Code { ASCII.Code(0x4F) }

    /// CAPITAL LETTER P (0x50).
    public static var P: ASCII.Code { ASCII.Code(0x50) }

    /// CAPITAL LETTER Q (0x51).
    public static var Q: ASCII.Code { ASCII.Code(0x51) }

    /// CAPITAL LETTER R (0x52).
    public static var R: ASCII.Code { ASCII.Code(0x52) }

    /// CAPITAL LETTER S (0x53).
    public static var S: ASCII.Code { ASCII.Code(0x53) }

    /// CAPITAL LETTER T (0x54).
    public static var T: ASCII.Code { ASCII.Code(0x54) }

    /// CAPITAL LETTER U (0x55).
    public static var U: ASCII.Code { ASCII.Code(0x55) }

    /// CAPITAL LETTER V (0x56).
    public static var V: ASCII.Code { ASCII.Code(0x56) }

    /// CAPITAL LETTER W (0x57).
    public static var W: ASCII.Code { ASCII.Code(0x57) }

    /// CAPITAL LETTER X (0x58).
    public static var X: ASCII.Code { ASCII.Code(0x58) }

    /// CAPITAL LETTER Y (0x59).
    public static var Y: ASCII.Code { ASCII.Code(0x59) }

    /// CAPITAL LETTER Z (0x5A).
    public static var Z: ASCII.Code { ASCII.Code(0x5A) }
}

// MARK: - Graphic Characters — Brackets and Symbols (0x5B-0x60)

extension ASCII.Code {

    /// LEFT BRACKET (0x5B) - [.
    public static var leftBracket: ASCII.Code { ASCII.Code(0x5B) }
    /// Alias for ``leftBracket``.
    public static var leftSquareBracket: ASCII.Code { ASCII.Code(0x5B) }

    /// REVERSE SLANT (0x5C) - backslash.
    public static var reverseSlant: ASCII.Code { ASCII.Code(0x5C) }
    /// Alias for ``reverseSlant``.
    public static var reverseSolidus: ASCII.Code { ASCII.Code(0x5C) }
    /// Alias for ``reverseSlant``.
    public static var backslash: ASCII.Code { ASCII.Code(0x5C) }

    /// RIGHT BRACKET (0x5D) - ].
    public static var rightBracket: ASCII.Code { ASCII.Code(0x5D) }
    /// Alias for ``rightBracket``.
    public static var rightSquareBracket: ASCII.Code { ASCII.Code(0x5D) }

    /// CIRCUMFLEX ACCENT (0x5E) - ^.
    public static var circumflexAccent: ASCII.Code { ASCII.Code(0x5E) }
    /// Alias for ``circumflexAccent``.
    public static var circumflex: ASCII.Code { ASCII.Code(0x5E) }

    /// UNDERLINE (LOW LINE) (0x5F) - _.
    public static var underline: ASCII.Code { ASCII.Code(0x5F) }
    /// Alias for ``underline``.
    public static var underscore: ASCII.Code { ASCII.Code(0x5F) }
    /// Alias for ``underline``.
    public static var lowLine: ASCII.Code { ASCII.Code(0x5F) }

    /// LEFT SINGLE QUOTATION MARK, GRAVE ACCENT (0x60), the backtick character.
    public static var leftSingleQuotationMark: ASCII.Code { ASCII.Code(0x60) }
    /// Alias for ``leftSingleQuotationMark``.
    public static var graveAccent: ASCII.Code { ASCII.Code(0x60) }
    /// Alias for ``leftSingleQuotationMark``.
    public static var backtick: ASCII.Code { ASCII.Code(0x60) }
}

// MARK: - Graphic Characters — Lowercase Letters (0x61-0x7A)

extension ASCII.Code {

    /// SMALL LETTER A (0x61).
    public static var a: ASCII.Code { ASCII.Code(0x61) }

    /// SMALL LETTER B (0x62).
    public static var b: ASCII.Code { ASCII.Code(0x62) }

    /// SMALL LETTER C (0x63).
    public static var c: ASCII.Code { ASCII.Code(0x63) }

    /// SMALL LETTER D (0x64).
    public static var d: ASCII.Code { ASCII.Code(0x64) }

    /// SMALL LETTER E (0x65).
    public static var e: ASCII.Code { ASCII.Code(0x65) }

    /// SMALL LETTER F (0x66).
    public static var f: ASCII.Code { ASCII.Code(0x66) }

    /// SMALL LETTER G (0x67).
    public static var g: ASCII.Code { ASCII.Code(0x67) }

    /// SMALL LETTER H (0x68).
    public static var h: ASCII.Code { ASCII.Code(0x68) }

    /// SMALL LETTER I (0x69).
    public static var i: ASCII.Code { ASCII.Code(0x69) }

    /// SMALL LETTER J (0x6A).
    public static var j: ASCII.Code { ASCII.Code(0x6A) }

    /// SMALL LETTER K (0x6B).
    public static var k: ASCII.Code { ASCII.Code(0x6B) }

    /// SMALL LETTER L (0x6C).
    public static var l: ASCII.Code { ASCII.Code(0x6C) }

    /// SMALL LETTER M (0x6D).
    public static var m: ASCII.Code { ASCII.Code(0x6D) }

    /// SMALL LETTER N (0x6E).
    public static var n: ASCII.Code { ASCII.Code(0x6E) }

    /// SMALL LETTER O (0x6F).
    public static var o: ASCII.Code { ASCII.Code(0x6F) }

    /// SMALL LETTER P (0x70).
    public static var p: ASCII.Code { ASCII.Code(0x70) }

    /// SMALL LETTER Q (0x71).
    public static var q: ASCII.Code { ASCII.Code(0x71) }

    /// SMALL LETTER R (0x72).
    public static var r: ASCII.Code { ASCII.Code(0x72) }

    /// SMALL LETTER S (0x73).
    public static var s: ASCII.Code { ASCII.Code(0x73) }

    /// SMALL LETTER T (0x74).
    public static var t: ASCII.Code { ASCII.Code(0x74) }

    /// SMALL LETTER U (0x75).
    public static var u: ASCII.Code { ASCII.Code(0x75) }

    /// SMALL LETTER V (0x76).
    public static var v: ASCII.Code { ASCII.Code(0x76) }

    /// SMALL LETTER W (0x77).
    public static var w: ASCII.Code { ASCII.Code(0x77) }

    /// SMALL LETTER X (0x78).
    public static var x: ASCII.Code { ASCII.Code(0x78) }

    /// SMALL LETTER Y (0x79).
    public static var y: ASCII.Code { ASCII.Code(0x79) }

    /// SMALL LETTER Z (0x7A).
    public static var z: ASCII.Code { ASCII.Code(0x7A) }
}

// MARK: - Graphic Characters — Final Symbols (0x7B-0x7E)

extension ASCII.Code {

    /// LEFT BRACE (0x7B) - {.
    public static var leftBrace: ASCII.Code { ASCII.Code(0x7B) }
    /// Alias for ``leftBrace``.
    public static var leftCurlyBracket: ASCII.Code { ASCII.Code(0x7B) }

    /// VERTICAL LINE (0x7C) - |.
    public static var verticalLine: ASCII.Code { ASCII.Code(0x7C) }

    /// RIGHT BRACE (0x7D) - }.
    public static var rightBrace: ASCII.Code { ASCII.Code(0x7D) }
    /// Alias for ``rightBrace``.
    public static var rightCurlyBracket: ASCII.Code { ASCII.Code(0x7D) }

    /// TILDE (OVERLINE) (0x7E) - ~.
    public static var tilde: ASCII.Code { ASCII.Code(0x7E) }
}
