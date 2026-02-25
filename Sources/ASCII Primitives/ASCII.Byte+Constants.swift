// ASCII.Byte+Constants.swift
// swift-ascii-primitives
//
// Static ASCII character constants on ASCII.Byte.

// MARK: - Control Characters

extension ASCII.Byte {

    /// NULL character (0x00)
    public static var nul: UInt8 { ASCII.ControlCharacters.nul }

    /// START OF HEADING (0x01)
    public static var soh: UInt8 { ASCII.ControlCharacters.soh }

    /// START OF TEXT (0x02)
    public static var stx: UInt8 { ASCII.ControlCharacters.stx }

    /// END OF TEXT (0x03)
    public static var etx: UInt8 { ASCII.ControlCharacters.etx }

    /// END OF TRANSMISSION (0x04)
    public static var eot: UInt8 { ASCII.ControlCharacters.eot }

    /// ENQUIRY (0x05)
    public static var enq: UInt8 { ASCII.ControlCharacters.enq }

    /// ACKNOWLEDGE (0x06)
    public static var ack: UInt8 { ASCII.ControlCharacters.ack }

    /// BELL (0x07)
    public static var bel: UInt8 { ASCII.ControlCharacters.bel }

    /// BACKSPACE (0x08)
    public static var bs: UInt8 { ASCII.ControlCharacters.bs }

    /// HORIZONTAL TAB (0x09)
    public static var htab: UInt8 { ASCII.ControlCharacters.htab }
    public static var tab: UInt8 { ASCII.ControlCharacters.htab }

    /// LINE FEED (0x0A)
    public static var lf: UInt8 { ASCII.ControlCharacters.lf }
    public static var newline: UInt8 { ASCII.ControlCharacters.lf }

    /// VERTICAL TAB (0x0B)
    public static var vtab: UInt8 { ASCII.ControlCharacters.vtab }

    /// FORM FEED (0x0C)
    public static var ff: UInt8 { ASCII.ControlCharacters.ff }

    /// CARRIAGE RETURN (0x0D)
    public static var cr: UInt8 { ASCII.ControlCharacters.cr }

    /// SHIFT OUT (0x0E)
    public static var so: UInt8 { ASCII.ControlCharacters.so }

    /// SHIFT IN (0x0F)
    public static var si: UInt8 { ASCII.ControlCharacters.si }

    /// DATA LINK ESCAPE (0x10)
    public static var dle: UInt8 { ASCII.ControlCharacters.dle }

    /// DEVICE CONTROL ONE (0x11)
    public static var dc1: UInt8 { ASCII.ControlCharacters.dc1 }

    /// DEVICE CONTROL TWO (0x12)
    public static var dc2: UInt8 { ASCII.ControlCharacters.dc2 }

    /// DEVICE CONTROL THREE (0x13)
    public static var dc3: UInt8 { ASCII.ControlCharacters.dc3 }

    /// DEVICE CONTROL FOUR (0x14)
    public static var dc4: UInt8 { ASCII.ControlCharacters.dc4 }

    /// NEGATIVE ACKNOWLEDGE (0x15)
    public static var nak: UInt8 { ASCII.ControlCharacters.nak }

    /// SYNCHRONOUS IDLE (0x16)
    public static var syn: UInt8 { ASCII.ControlCharacters.syn }

    /// END OF TRANSMISSION BLOCK (0x17)
    public static var etb: UInt8 { ASCII.ControlCharacters.etb }

    /// CANCEL (0x18)
    public static var can: UInt8 { ASCII.ControlCharacters.can }

    /// END OF MEDIUM (0x19)
    public static var em: UInt8 { ASCII.ControlCharacters.em }

    /// SUBSTITUTE (0x1A)
    public static var sub: UInt8 { ASCII.ControlCharacters.sub }

    /// ESCAPE (0x1B)
    public static var esc: UInt8 { ASCII.ControlCharacters.esc }

    /// FILE SEPARATOR (0x1C)
    public static var fs: UInt8 { ASCII.ControlCharacters.fs }

    /// GROUP SEPARATOR (0x1D)
    public static var gs: UInt8 { ASCII.ControlCharacters.gs }

    /// RECORD SEPARATOR (0x1E)
    public static var rs: UInt8 { ASCII.ControlCharacters.rs }

    /// UNIT SEPARATOR (0x1F)
    public static var us: UInt8 { ASCII.ControlCharacters.us }

    /// DELETE (0x7F)
    public static var del: UInt8 { ASCII.ControlCharacters.del }
}

// MARK: - SPACE

extension ASCII.Byte {

    /// SPACE (0x20)
    public static var sp: UInt8 { ASCII.SPACE.sp }
    public static var space: UInt8 { ASCII.SPACE.sp }
}

// MARK: - Graphic Characters — Punctuation

extension ASCII.Byte {

    /// EXCLAMATION POINT (0x21) - !
    public static var exclamationPoint: UInt8 { ASCII.GraphicCharacters.exclamationPoint }

    /// QUOTATION MARK (0x22) - "
    public static var quotationMark: UInt8 { ASCII.GraphicCharacters.quotationMark }
    public static var dquote: UInt8 { ASCII.GraphicCharacters.quotationMark }
    public static var doubleQuote: UInt8 { ASCII.GraphicCharacters.quotationMark }

    /// NUMBER SIGN (0x23) - #
    public static var numberSign: UInt8 { ASCII.GraphicCharacters.numberSign }

    /// DOLLAR SIGN (0x24) - $
    public static var dollarSign: UInt8 { ASCII.GraphicCharacters.dollarSign }

    /// PERCENT SIGN (0x25) - %
    public static var percentSign: UInt8 { ASCII.GraphicCharacters.percentSign }

    /// AMPERSAND (0x26) - &
    public static var ampersand: UInt8 { ASCII.GraphicCharacters.ampersand }

    /// APOSTROPHE (0x27) - '
    public static var apostrophe: UInt8 { ASCII.GraphicCharacters.apostrophe }

    /// LEFT PARENTHESIS (0x28) - (
    public static var leftParenthesis: UInt8 { ASCII.GraphicCharacters.leftParenthesis }

    /// RIGHT PARENTHESIS (0x29) - )
    public static var rightParenthesis: UInt8 { ASCII.GraphicCharacters.rightParenthesis }

    /// ASTERISK (0x2A) - *
    public static var asterisk: UInt8 { ASCII.GraphicCharacters.asterisk }

    /// PLUS SIGN (0x2B) - +
    public static var plusSign: UInt8 { ASCII.GraphicCharacters.plusSign }
    public static var plus: UInt8 { ASCII.GraphicCharacters.plusSign }

    /// COMMA (0x2C) - ,
    public static var comma: UInt8 { ASCII.GraphicCharacters.comma }

    /// HYPHEN, MINUS SIGN (0x2D) - -
    public static var hyphen: UInt8 { ASCII.GraphicCharacters.hyphen }

    /// PERIOD, DECIMAL POINT (0x2E) - .
    public static var period: UInt8 { ASCII.GraphicCharacters.period }

    /// SLANT (SOLIDUS) (0x2F) - /
    public static var slant: UInt8 { ASCII.GraphicCharacters.slant }
    public static var solidus: UInt8 { ASCII.GraphicCharacters.solidus }
    public static var slash: UInt8 { ASCII.GraphicCharacters.slant }
    public static var forwardSlash: UInt8 { ASCII.GraphicCharacters.slant }
}

// MARK: - Graphic Characters — Digits

extension ASCII.Byte {

    /// DIGIT ZERO (0x30) - 0
    public static var `0`: UInt8 { ASCII.GraphicCharacters.`0` }

    /// DIGIT ONE (0x31) - 1
    public static var `1`: UInt8 { ASCII.GraphicCharacters.`1` }

    /// DIGIT TWO (0x32) - 2
    public static var `2`: UInt8 { ASCII.GraphicCharacters.`2` }

    /// DIGIT THREE (0x33) - 3
    public static var `3`: UInt8 { ASCII.GraphicCharacters.`3` }

    /// DIGIT FOUR (0x34) - 4
    public static var `4`: UInt8 { ASCII.GraphicCharacters.`4` }

    /// DIGIT FIVE (0x35) - 5
    public static var `5`: UInt8 { ASCII.GraphicCharacters.`5` }

    /// DIGIT SIX (0x36) - 6
    public static var `6`: UInt8 { ASCII.GraphicCharacters.`6` }

    /// DIGIT SEVEN (0x37) - 7
    public static var `7`: UInt8 { ASCII.GraphicCharacters.`7` }

    /// DIGIT EIGHT (0x38) - 8
    public static var `8`: UInt8 { ASCII.GraphicCharacters.`8` }

    /// DIGIT NINE (0x39) - 9
    public static var `9`: UInt8 { ASCII.GraphicCharacters.`9` }
}

// MARK: - Graphic Characters — More Punctuation

extension ASCII.Byte {

    /// COLON (0x3A) - :
    public static var colon: UInt8 { ASCII.GraphicCharacters.colon }

    /// SEMICOLON (0x3B) - ;
    public static var semicolon: UInt8 { ASCII.GraphicCharacters.semicolon }

    /// LESS-THAN SIGN (0x3C) - <
    public static var lessThanSign: UInt8 { ASCII.GraphicCharacters.lessThanSign }
    public static var lt: UInt8 { ASCII.GraphicCharacters.lessThanSign }
    public static var lessThan: UInt8 { ASCII.GraphicCharacters.lessThanSign }

    /// EQUALS SIGN (0x3D) - =
    public static var equalsSign: UInt8 { ASCII.GraphicCharacters.equalsSign }

    /// GREATER-THAN SIGN (0x3E) - >
    public static var greaterThanSign: UInt8 { ASCII.GraphicCharacters.greaterThanSign }
    public static var gt: UInt8 { ASCII.GraphicCharacters.greaterThanSign }
    public static var greaterThan: UInt8 { ASCII.GraphicCharacters.greaterThanSign }

    /// QUESTION MARK (0x3F) - ?
    public static var questionMark: UInt8 { ASCII.GraphicCharacters.questionMark }

    /// COMMERCIAL AT (0x40) - @
    public static var commercialAt: UInt8 { ASCII.GraphicCharacters.commercialAt }
    public static var at: UInt8 { ASCII.GraphicCharacters.commercialAt }
    public static var atSign: UInt8 { ASCII.GraphicCharacters.commercialAt }
}

// MARK: - Graphic Characters — Uppercase Letters

extension ASCII.Byte {

    /// CAPITAL LETTER A (0x41)
    public static var A: UInt8 { ASCII.GraphicCharacters.A }

    /// CAPITAL LETTER B (0x42)
    public static var B: UInt8 { ASCII.GraphicCharacters.B }

    /// CAPITAL LETTER C (0x43)
    public static var C: UInt8 { ASCII.GraphicCharacters.C }

    /// CAPITAL LETTER D (0x44)
    public static var D: UInt8 { ASCII.GraphicCharacters.D }

    /// CAPITAL LETTER E (0x45)
    public static var E: UInt8 { ASCII.GraphicCharacters.E }

    /// CAPITAL LETTER F (0x46)
    public static var F: UInt8 { ASCII.GraphicCharacters.F }

    /// CAPITAL LETTER G (0x47)
    public static var G: UInt8 { ASCII.GraphicCharacters.G }

    /// CAPITAL LETTER H (0x48)
    public static var H: UInt8 { ASCII.GraphicCharacters.H }

    /// CAPITAL LETTER I (0x49)
    public static var I: UInt8 { ASCII.GraphicCharacters.I }

    /// CAPITAL LETTER J (0x4A)
    public static var J: UInt8 { ASCII.GraphicCharacters.J }

    /// CAPITAL LETTER K (0x4B)
    public static var K: UInt8 { ASCII.GraphicCharacters.K }

    /// CAPITAL LETTER L (0x4C)
    public static var L: UInt8 { ASCII.GraphicCharacters.L }

    /// CAPITAL LETTER M (0x4D)
    public static var M: UInt8 { ASCII.GraphicCharacters.M }

    /// CAPITAL LETTER N (0x4E)
    public static var N: UInt8 { ASCII.GraphicCharacters.N }

    /// CAPITAL LETTER O (0x4F)
    public static var O: UInt8 { ASCII.GraphicCharacters.O }

    /// CAPITAL LETTER P (0x50)
    public static var P: UInt8 { ASCII.GraphicCharacters.P }

    /// CAPITAL LETTER Q (0x51)
    public static var Q: UInt8 { ASCII.GraphicCharacters.Q }

    /// CAPITAL LETTER R (0x52)
    public static var R: UInt8 { ASCII.GraphicCharacters.R }

    /// CAPITAL LETTER S (0x53)
    public static var S: UInt8 { ASCII.GraphicCharacters.S }

    /// CAPITAL LETTER T (0x54)
    public static var T: UInt8 { ASCII.GraphicCharacters.T }

    /// CAPITAL LETTER U (0x55)
    public static var U: UInt8 { ASCII.GraphicCharacters.U }

    /// CAPITAL LETTER V (0x56)
    public static var V: UInt8 { ASCII.GraphicCharacters.V }

    /// CAPITAL LETTER W (0x57)
    public static var W: UInt8 { ASCII.GraphicCharacters.W }

    /// CAPITAL LETTER X (0x58)
    public static var X: UInt8 { ASCII.GraphicCharacters.X }

    /// CAPITAL LETTER Y (0x59)
    public static var Y: UInt8 { ASCII.GraphicCharacters.Y }

    /// CAPITAL LETTER Z (0x5A)
    public static var Z: UInt8 { ASCII.GraphicCharacters.Z }
}

// MARK: - Graphic Characters — Brackets and Symbols

extension ASCII.Byte {

    /// LEFT BRACKET (0x5B) - [
    public static var leftBracket: UInt8 { ASCII.GraphicCharacters.leftBracket }
    public static var leftSquareBracket: UInt8 { ASCII.GraphicCharacters.leftBracket }

    /// REVERSE SLANT (0x5C) - backslash
    public static var reverseSlant: UInt8 { ASCII.GraphicCharacters.reverseSlant }
    public static var reverseSolidus: UInt8 { ASCII.GraphicCharacters.reverseSolidus }
    public static var backslash: UInt8 { ASCII.GraphicCharacters.reverseSolidus }

    /// RIGHT BRACKET (0x5D) - ]
    public static var rightBracket: UInt8 { ASCII.GraphicCharacters.rightBracket }
    public static var rightSquareBracket: UInt8 { ASCII.GraphicCharacters.rightBracket }

    /// CIRCUMFLEX ACCENT (0x5E) - ^
    public static var circumflexAccent: UInt8 { ASCII.GraphicCharacters.circumflexAccent }

    /// UNDERLINE (LOW LINE) (0x5F) - _
    public static var underline: UInt8 { ASCII.GraphicCharacters.underline }

    /// LEFT SINGLE QUOTATION MARK, GRAVE ACCENT (0x60) - `
    public static var leftSingleQuotationMark: UInt8 { ASCII.GraphicCharacters.leftSingleQuotationMark }
}

// MARK: - Graphic Characters — Lowercase Letters

extension ASCII.Byte {

    /// SMALL LETTER A (0x61)
    public static var a: UInt8 { ASCII.GraphicCharacters.a }

    /// SMALL LETTER B (0x62)
    public static var b: UInt8 { ASCII.GraphicCharacters.b }

    /// SMALL LETTER C (0x63)
    public static var c: UInt8 { ASCII.GraphicCharacters.c }

    /// SMALL LETTER D (0x64)
    public static var d: UInt8 { ASCII.GraphicCharacters.d }

    /// SMALL LETTER E (0x65)
    public static var e: UInt8 { ASCII.GraphicCharacters.e }

    /// SMALL LETTER F (0x66)
    public static var f: UInt8 { ASCII.GraphicCharacters.f }

    /// SMALL LETTER G (0x67)
    public static var g: UInt8 { ASCII.GraphicCharacters.g }

    /// SMALL LETTER H (0x68)
    public static var h: UInt8 { ASCII.GraphicCharacters.h }

    /// SMALL LETTER I (0x69)
    public static var i: UInt8 { ASCII.GraphicCharacters.i }

    /// SMALL LETTER J (0x6A)
    public static var j: UInt8 { ASCII.GraphicCharacters.j }

    /// SMALL LETTER K (0x6B)
    public static var k: UInt8 { ASCII.GraphicCharacters.k }

    /// SMALL LETTER L (0x6C)
    public static var l: UInt8 { ASCII.GraphicCharacters.l }

    /// SMALL LETTER M (0x6D)
    public static var m: UInt8 { ASCII.GraphicCharacters.m }

    /// SMALL LETTER N (0x6E)
    public static var n: UInt8 { ASCII.GraphicCharacters.n }

    /// SMALL LETTER O (0x6F)
    public static var o: UInt8 { ASCII.GraphicCharacters.o }

    /// SMALL LETTER P (0x70)
    public static var p: UInt8 { ASCII.GraphicCharacters.p }

    /// SMALL LETTER Q (0x71)
    public static var q: UInt8 { ASCII.GraphicCharacters.q }

    /// SMALL LETTER R (0x72)
    public static var r: UInt8 { ASCII.GraphicCharacters.r }

    /// SMALL LETTER S (0x73)
    public static var s: UInt8 { ASCII.GraphicCharacters.s }

    /// SMALL LETTER T (0x74)
    public static var t: UInt8 { ASCII.GraphicCharacters.t }

    /// SMALL LETTER U (0x75)
    public static var u: UInt8 { ASCII.GraphicCharacters.u }

    /// SMALL LETTER V (0x76)
    public static var v: UInt8 { ASCII.GraphicCharacters.v }

    /// SMALL LETTER W (0x77)
    public static var w: UInt8 { ASCII.GraphicCharacters.w }

    /// SMALL LETTER X (0x78)
    public static var x: UInt8 { ASCII.GraphicCharacters.x }

    /// SMALL LETTER Y (0x79)
    public static var y: UInt8 { ASCII.GraphicCharacters.y }

    /// SMALL LETTER Z (0x7A)
    public static var z: UInt8 { ASCII.GraphicCharacters.z }
}

// MARK: - Graphic Characters — Final Symbols

extension ASCII.Byte {

    /// LEFT BRACE (0x7B) - {
    public static var leftBrace: UInt8 { ASCII.GraphicCharacters.leftBrace }

    /// VERTICAL LINE (0x7C) - |
    public static var verticalLine: UInt8 { ASCII.GraphicCharacters.verticalLine }

    /// RIGHT BRACE (0x7D) - }
    public static var rightBrace: UInt8 { ASCII.GraphicCharacters.rightBrace }

    /// TILDE (OVERLINE) (0x7E) - ~
    public static var tilde: UInt8 { ASCII.GraphicCharacters.tilde }
}
