// Carrier.Protocol+ASCII.swift
// swift-ascii-primitives
//
// Self-resolving ASCII byte-value constants on `Carrier.\`Protocol\``
// where `Underlying == UInt8`.
//
// All UInt8-carriers — `UInt8` itself (trivial self-carrier), `Byte`,
// `ASCII.Code`, future byte-domain newtypes (Latin1.Byte, UTF8.Code_Unit,
// RFC-typed octets), and `Tagged<Tag, T>` where T conforms — gain the
// `.ascii.X` accessor whose constants resolve to `Self`:
//
// ```swift
// UInt8.ascii.space      // UInt8 (0x20)
// Byte.ascii.space       // Byte
// ASCII.Code.ascii.space // ASCII.Code
// ```
//
// The companion UInt8-explicit constants on `ASCII.Code` (in
// `ASCII.Code+Constants.swift`) delegate to this Self-resolving form
// to preserve `Collection<UInt8>` consumer compatibility (e.g.
// `bytes.contains(ASCII.Code.space)` where `bytes: [UInt8]`).
//
// **Scope decision**: this extension lives on `Carrier.\`Protocol\`
// where Underlying == UInt8`, NOT on `Byte.\`Protocol\``. The
// `byte-protocol-capability-marker.md` discipline distinguishes
// *behaviors* (operators that would dissolve the byte/arithmetic
// identity separation — Byte deliberately lacks `+`, etc.) from *value
// lookups* (constants like `.space = 0x20`). Adding `.ascii.X: Self`
// to UInt8 is value clarity at the substrate, not behavioral leak:
// UInt8's lack of byte-domain operators is preserved; Byte still owns
// bitwise/parser semantics via `Byte.\`Protocol\``; UInt8 owns
// arithmetic; the value-access surface is shared.
//
// **Naming**: `byte.ascii.space` (with the `.ascii.` namespace prefix)
// not `byte.space` directly. The prefix documents that the constant
// carries ASCII-encoded byte semantics, distinguishing from byte-value
// constants that might be defined for other encodings (Latin-1, EBCDIC,
// etc.).

public import Byte_Primitives
public import Carrier_Primitives

extension Carrier.`Protocol` where Underlying == UInt8 {

    /// Type-level access to ASCII byte-value constants.
    ///
    /// The namespace's constants resolve to `Self`, so the same `.ascii.X`
    /// shape produces the appropriate type at each consumer:
    ///
    /// ```swift
    /// UInt8.ascii.space      // UInt8 (0x20)
    /// Byte.ascii.space       // Byte
    /// ASCII.Code.ascii.space // ASCII.Code
    /// ```
    @inlinable
    public static var ascii: ASCII.Namespace<Self>.Type {
        ASCII.Namespace<Self>.self
    }
}

extension ASCII {

    /// Generic namespace carrying ASCII byte-value constants typed to a
    /// UInt8-carrier `Owner`.
    ///
    /// Used as a type-level accessor — never instantiated.
    ///
    /// Constants are defined per ASCII control-character section
    /// (INCITS 4-1986 Table 1) and per graphic-character section
    /// (INCITS 4-1986 Tables 2–7). Each constant returns `Owner`,
    /// resolving to the caller-side byte-domain type.
    @frozen
    public enum Namespace<Owner: Carrier.`Protocol`> where Owner.Underlying == UInt8 {}
}

// MARK: - Control Characters (0x00–0x1F, 0x7F)

extension ASCII.Namespace {

    /// NULL (0x00).
    @inlinable public static var nul: Owner { Owner(0x00 as UInt8) }

    /// START OF HEADING (0x01).
    @inlinable public static var soh: Owner { Owner(0x01 as UInt8) }

    /// START OF TEXT (0x02).
    @inlinable public static var stx: Owner { Owner(0x02 as UInt8) }

    /// END OF TEXT (0x03).
    @inlinable public static var etx: Owner { Owner(0x03 as UInt8) }

    /// END OF TRANSMISSION (0x04).
    @inlinable public static var eot: Owner { Owner(0x04 as UInt8) }

    /// ENQUIRY (0x05).
    @inlinable public static var enq: Owner { Owner(0x05 as UInt8) }

    /// ACKNOWLEDGE (0x06).
    @inlinable public static var ack: Owner { Owner(0x06 as UInt8) }

    /// BELL (0x07).
    @inlinable public static var bel: Owner { Owner(0x07 as UInt8) }

    /// BACKSPACE (0x08).
    @inlinable public static var bs: Owner { Owner(0x08 as UInt8) }

    /// HORIZONTAL TAB (0x09).
    @inlinable public static var htab: Owner { Owner(0x09 as UInt8) }

    /// Alias for ``htab``.
    @inlinable public static var tab: Owner { Owner(0x09 as UInt8) }

    /// LINE FEED (0x0A).
    @inlinable public static var lf: Owner { Owner(0x0A as UInt8) }

    /// Alias for ``lf``.
    @inlinable public static var newline: Owner { Owner(0x0A as UInt8) }

    /// VERTICAL TAB (0x0B).
    @inlinable public static var vtab: Owner { Owner(0x0B as UInt8) }

    /// FORM FEED (0x0C).
    @inlinable public static var ff: Owner { Owner(0x0C as UInt8) }

    /// CARRIAGE RETURN (0x0D).
    @inlinable public static var cr: Owner { Owner(0x0D as UInt8) }

    /// SHIFT OUT (0x0E).
    @inlinable public static var so: Owner { Owner(0x0E as UInt8) }

    /// SHIFT IN (0x0F).
    @inlinable public static var si: Owner { Owner(0x0F as UInt8) }

    /// DATA LINK ESCAPE (0x10).
    @inlinable public static var dle: Owner { Owner(0x10 as UInt8) }

    /// DEVICE CONTROL ONE (0x11).
    @inlinable public static var dc1: Owner { Owner(0x11 as UInt8) }

    /// DEVICE CONTROL TWO (0x12).
    @inlinable public static var dc2: Owner { Owner(0x12 as UInt8) }

    /// DEVICE CONTROL THREE (0x13).
    @inlinable public static var dc3: Owner { Owner(0x13 as UInt8) }

    /// DEVICE CONTROL FOUR (0x14).
    @inlinable public static var dc4: Owner { Owner(0x14 as UInt8) }

    /// NEGATIVE ACKNOWLEDGE (0x15).
    @inlinable public static var nak: Owner { Owner(0x15 as UInt8) }

    /// SYNCHRONOUS IDLE (0x16).
    @inlinable public static var syn: Owner { Owner(0x16 as UInt8) }

    /// END OF TRANSMISSION BLOCK (0x17).
    @inlinable public static var etb: Owner { Owner(0x17 as UInt8) }

    /// CANCEL (0x18).
    @inlinable public static var can: Owner { Owner(0x18 as UInt8) }

    /// END OF MEDIUM (0x19).
    @inlinable public static var em: Owner { Owner(0x19 as UInt8) }

    /// SUBSTITUTE (0x1A).
    @inlinable public static var sub: Owner { Owner(0x1A as UInt8) }

    /// ESCAPE (0x1B).
    @inlinable public static var esc: Owner { Owner(0x1B as UInt8) }

    /// FILE SEPARATOR (0x1C).
    @inlinable public static var fs: Owner { Owner(0x1C as UInt8) }

    /// GROUP SEPARATOR (0x1D).
    @inlinable public static var gs: Owner { Owner(0x1D as UInt8) }

    /// RECORD SEPARATOR (0x1E).
    @inlinable public static var rs: Owner { Owner(0x1E as UInt8) }

    /// UNIT SEPARATOR (0x1F).
    @inlinable public static var us: Owner { Owner(0x1F as UInt8) }

    /// DELETE (0x7F).
    @inlinable public static var del: Owner { Owner(0x7F as UInt8) }
}

// MARK: - SPACE (0x20)

extension ASCII.Namespace {

    /// SPACE (0x20).
    @inlinable public static var sp: Owner { Owner(0x20 as UInt8) }

    /// Alias for ``sp``.
    @inlinable public static var space: Owner { Owner(0x20 as UInt8) }
}

// MARK: - Graphic Punctuation (0x21–0x2F)

extension ASCII.Namespace {

    /// EXCLAMATION POINT `!` (0x21).
    @inlinable public static var exclamationPoint: Owner { Owner(0x21 as UInt8) }

    /// QUOTATION MARK `"` (0x22).
    @inlinable public static var quotationMark: Owner { Owner(0x22 as UInt8) }

    /// Alias for ``quotationMark``.
    @inlinable public static var dquote: Owner { Owner(0x22 as UInt8) }

    /// Alias for ``quotationMark``.
    @inlinable public static var doubleQuote: Owner { Owner(0x22 as UInt8) }

    /// NUMBER SIGN `#` (0x23).
    @inlinable public static var numberSign: Owner { Owner(0x23 as UInt8) }

    /// DOLLAR SIGN `$` (0x24).
    @inlinable public static var dollarSign: Owner { Owner(0x24 as UInt8) }

    /// PERCENT SIGN `%` (0x25).
    @inlinable public static var percentSign: Owner { Owner(0x25 as UInt8) }

    /// AMPERSAND `&` (0x26).
    @inlinable public static var ampersand: Owner { Owner(0x26 as UInt8) }

    /// APOSTROPHE `'` (0x27).
    @inlinable public static var apostrophe: Owner { Owner(0x27 as UInt8) }

    /// LEFT PARENTHESIS `(` (0x28).
    @inlinable public static var leftParenthesis: Owner { Owner(0x28 as UInt8) }

    /// RIGHT PARENTHESIS `)` (0x29).
    @inlinable public static var rightParenthesis: Owner { Owner(0x29 as UInt8) }

    /// ASTERISK `*` (0x2A).
    @inlinable public static var asterisk: Owner { Owner(0x2A as UInt8) }

    /// PLUS SIGN `+` (0x2B).
    @inlinable public static var plusSign: Owner { Owner(0x2B as UInt8) }

    /// Alias for ``plusSign``.
    @inlinable public static var plus: Owner { Owner(0x2B as UInt8) }

    /// COMMA `,` (0x2C).
    @inlinable public static var comma: Owner { Owner(0x2C as UInt8) }

    /// HYPHEN, MINUS SIGN `-` (0x2D).
    @inlinable public static var hyphen: Owner { Owner(0x2D as UInt8) }

    /// PERIOD, DECIMAL POINT `.` (0x2E).
    @inlinable public static var period: Owner { Owner(0x2E as UInt8) }

    /// SLANT (SOLIDUS) `/` (0x2F).
    @inlinable public static var slant: Owner { Owner(0x2F as UInt8) }

    /// Alias for ``slant``.
    @inlinable public static var solidus: Owner { Owner(0x2F as UInt8) }

    /// Alias for ``slant``.
    @inlinable public static var slash: Owner { Owner(0x2F as UInt8) }

    /// Alias for ``slant``.
    @inlinable public static var forwardSlash: Owner { Owner(0x2F as UInt8) }
}

// MARK: - Graphic Digits (0x30–0x39)

extension ASCII.Namespace {

    /// DIGIT ZERO `0` (0x30).
    @inlinable public static var `0`: Owner { Owner(0x30 as UInt8) }

    /// DIGIT ONE `1` (0x31).
    @inlinable public static var `1`: Owner { Owner(0x31 as UInt8) }

    /// DIGIT TWO `2` (0x32).
    @inlinable public static var `2`: Owner { Owner(0x32 as UInt8) }

    /// DIGIT THREE `3` (0x33).
    @inlinable public static var `3`: Owner { Owner(0x33 as UInt8) }

    /// DIGIT FOUR `4` (0x34).
    @inlinable public static var `4`: Owner { Owner(0x34 as UInt8) }

    /// DIGIT FIVE `5` (0x35).
    @inlinable public static var `5`: Owner { Owner(0x35 as UInt8) }

    /// DIGIT SIX `6` (0x36).
    @inlinable public static var `6`: Owner { Owner(0x36 as UInt8) }

    /// DIGIT SEVEN `7` (0x37).
    @inlinable public static var `7`: Owner { Owner(0x37 as UInt8) }

    /// DIGIT EIGHT `8` (0x38).
    @inlinable public static var `8`: Owner { Owner(0x38 as UInt8) }

    /// DIGIT NINE `9` (0x39).
    @inlinable public static var `9`: Owner { Owner(0x39 as UInt8) }
}

// MARK: - Graphic Punctuation (0x3A–0x40)

extension ASCII.Namespace {

    /// COLON `:` (0x3A).
    @inlinable public static var colon: Owner { Owner(0x3A as UInt8) }

    /// SEMICOLON `;` (0x3B).
    @inlinable public static var semicolon: Owner { Owner(0x3B as UInt8) }

    /// LESS-THAN SIGN `<` (0x3C).
    @inlinable public static var lessThanSign: Owner { Owner(0x3C as UInt8) }

    /// Alias for ``lessThanSign``.
    @inlinable public static var lt: Owner { Owner(0x3C as UInt8) }

    /// Alias for ``lessThanSign``.
    @inlinable public static var lessThan: Owner { Owner(0x3C as UInt8) }

    /// EQUALS SIGN `=` (0x3D).
    @inlinable public static var equalsSign: Owner { Owner(0x3D as UInt8) }

    /// GREATER-THAN SIGN `>` (0x3E).
    @inlinable public static var greaterThanSign: Owner { Owner(0x3E as UInt8) }

    /// Alias for ``greaterThanSign``.
    @inlinable public static var gt: Owner { Owner(0x3E as UInt8) }

    /// Alias for ``greaterThanSign``.
    @inlinable public static var greaterThan: Owner { Owner(0x3E as UInt8) }

    /// QUESTION MARK `?` (0x3F).
    @inlinable public static var questionMark: Owner { Owner(0x3F as UInt8) }

    /// COMMERCIAL AT `@` (0x40).
    @inlinable public static var commercialAt: Owner { Owner(0x40 as UInt8) }

    /// Alias for ``commercialAt``.
    @inlinable public static var at: Owner { Owner(0x40 as UInt8) }

    /// Alias for ``commercialAt``.
    @inlinable public static var atSign: Owner { Owner(0x40 as UInt8) }
}

// MARK: - Graphic Uppercase Letters (0x41–0x5A)

extension ASCII.Namespace {

    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER A (0x41).
    @inlinable public static var A: Owner { Owner(0x41 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER B (0x42).
    @inlinable public static var B: Owner { Owner(0x42 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER C (0x43).
    @inlinable public static var C: Owner { Owner(0x43 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER D (0x44).
    @inlinable public static var D: Owner { Owner(0x44 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER E (0x45).
    @inlinable public static var E: Owner { Owner(0x45 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER F (0x46).
    @inlinable public static var F: Owner { Owner(0x46 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER G (0x47).
    @inlinable public static var G: Owner { Owner(0x47 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER H (0x48).
    @inlinable public static var H: Owner { Owner(0x48 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER I (0x49).
    @inlinable public static var I: Owner { Owner(0x49 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER J (0x4A).
    @inlinable public static var J: Owner { Owner(0x4A as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER K (0x4B).
    @inlinable public static var K: Owner { Owner(0x4B as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER L (0x4C).
    @inlinable public static var L: Owner { Owner(0x4C as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER M (0x4D).
    @inlinable public static var M: Owner { Owner(0x4D as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER N (0x4E).
    @inlinable public static var N: Owner { Owner(0x4E as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER O (0x4F).
    @inlinable public static var O: Owner { Owner(0x4F as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER P (0x50).
    @inlinable public static var P: Owner { Owner(0x50 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER Q (0x51).
    @inlinable public static var Q: Owner { Owner(0x51 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER R (0x52).
    @inlinable public static var R: Owner { Owner(0x52 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER S (0x53).
    @inlinable public static var S: Owner { Owner(0x53 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER T (0x54).
    @inlinable public static var T: Owner { Owner(0x54 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER U (0x55).
    @inlinable public static var U: Owner { Owner(0x55 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER V (0x56).
    @inlinable public static var V: Owner { Owner(0x56 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER W (0x57).
    @inlinable public static var W: Owner { Owner(0x57 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER X (0x58).
    @inlinable public static var X: Owner { Owner(0x58 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER Y (0x59).
    @inlinable public static var Y: Owner { Owner(0x59 as UInt8) }
    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// CAPITAL LETTER Z (0x5A).
    @inlinable public static var Z: Owner { Owner(0x5A as UInt8) }
}

// MARK: - Graphic Brackets & Symbols (0x5B–0x60)

extension ASCII.Namespace {

    /// LEFT BRACKET `[` (0x5B).
    @inlinable public static var leftBracket: Owner { Owner(0x5B as UInt8) }

    /// Alias for ``leftBracket``.
    @inlinable public static var leftSquareBracket: Owner { Owner(0x5B as UInt8) }

    /// REVERSE SLANT `\` (0x5C).
    @inlinable public static var reverseSlant: Owner { Owner(0x5C as UInt8) }

    /// Alias for ``reverseSlant``.
    @inlinable public static var reverseSolidus: Owner { Owner(0x5C as UInt8) }

    /// Alias for ``reverseSlant``.
    @inlinable public static var backslash: Owner { Owner(0x5C as UInt8) }

    /// RIGHT BRACKET `]` (0x5D).
    @inlinable public static var rightBracket: Owner { Owner(0x5D as UInt8) }

    /// Alias for ``rightBracket``.
    @inlinable public static var rightSquareBracket: Owner { Owner(0x5D as UInt8) }

    /// CIRCUMFLEX ACCENT `^` (0x5E).
    @inlinable public static var circumflexAccent: Owner { Owner(0x5E as UInt8) }

    /// UNDERLINE `_` (0x5F).
    @inlinable public static var underline: Owner { Owner(0x5F as UInt8) }

    /// GRAVE ACCENT `` ` `` (0x60).
    @inlinable public static var leftSingleQuotationMark: Owner { Owner(0x60 as UInt8) }
}

// MARK: - Graphic Lowercase Letters (0x61–0x7A)

extension ASCII.Namespace {

    /// SMALL LETTER A (0x61).
    @inlinable public static var a: Owner { Owner(0x61 as UInt8) }
    /// SMALL LETTER B (0x62).
    @inlinable public static var b: Owner { Owner(0x62 as UInt8) }
    /// SMALL LETTER C (0x63).
    @inlinable public static var c: Owner { Owner(0x63 as UInt8) }
    /// SMALL LETTER D (0x64).
    @inlinable public static var d: Owner { Owner(0x64 as UInt8) }
    /// SMALL LETTER E (0x65).
    @inlinable public static var e: Owner { Owner(0x65 as UInt8) }
    /// SMALL LETTER F (0x66).
    @inlinable public static var f: Owner { Owner(0x66 as UInt8) }
    /// SMALL LETTER G (0x67).
    @inlinable public static var g: Owner { Owner(0x67 as UInt8) }
    /// SMALL LETTER H (0x68).
    @inlinable public static var h: Owner { Owner(0x68 as UInt8) }
    /// SMALL LETTER I (0x69).
    @inlinable public static var i: Owner { Owner(0x69 as UInt8) }
    /// SMALL LETTER J (0x6A).
    @inlinable public static var j: Owner { Owner(0x6A as UInt8) }
    /// SMALL LETTER K (0x6B).
    @inlinable public static var k: Owner { Owner(0x6B as UInt8) }
    /// SMALL LETTER L (0x6C).
    @inlinable public static var l: Owner { Owner(0x6C as UInt8) }
    /// SMALL LETTER M (0x6D).
    @inlinable public static var m: Owner { Owner(0x6D as UInt8) }
    /// SMALL LETTER N (0x6E).
    @inlinable public static var n: Owner { Owner(0x6E as UInt8) }
    /// SMALL LETTER O (0x6F).
    @inlinable public static var o: Owner { Owner(0x6F as UInt8) }
    /// SMALL LETTER P (0x70).
    @inlinable public static var p: Owner { Owner(0x70 as UInt8) }
    /// SMALL LETTER Q (0x71).
    @inlinable public static var q: Owner { Owner(0x71 as UInt8) }
    /// SMALL LETTER R (0x72).
    @inlinable public static var r: Owner { Owner(0x72 as UInt8) }
    /// SMALL LETTER S (0x73).
    @inlinable public static var s: Owner { Owner(0x73 as UInt8) }
    /// SMALL LETTER T (0x74).
    @inlinable public static var t: Owner { Owner(0x74 as UInt8) }
    /// SMALL LETTER U (0x75).
    @inlinable public static var u: Owner { Owner(0x75 as UInt8) }
    /// SMALL LETTER V (0x76).
    @inlinable public static var v: Owner { Owner(0x76 as UInt8) }
    /// SMALL LETTER W (0x77).
    @inlinable public static var w: Owner { Owner(0x77 as UInt8) }
    /// SMALL LETTER X (0x78).
    @inlinable public static var x: Owner { Owner(0x78 as UInt8) }
    /// SMALL LETTER Y (0x79).
    @inlinable public static var y: Owner { Owner(0x79 as UInt8) }
    /// SMALL LETTER Z (0x7A).
    @inlinable public static var z: Owner { Owner(0x7A as UInt8) }
}

// MARK: - Graphic Final Symbols (0x7B–0x7E)

extension ASCII.Namespace {

    /// LEFT BRACE `{` (0x7B).
    @inlinable public static var leftBrace: Owner { Owner(0x7B as UInt8) }

    /// VERTICAL LINE `|` (0x7C).
    @inlinable public static var verticalLine: Owner { Owner(0x7C as UInt8) }

    /// RIGHT BRACE `}` (0x7D).
    @inlinable public static var rightBrace: Owner { Owner(0x7D as UInt8) }

    /// TILDE (OVERLINE) `~` (0x7E).
    @inlinable public static var tilde: Owner { Owner(0x7E as UInt8) }
}
