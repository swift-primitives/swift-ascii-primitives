public import Byte
import Carrier

extension Carrier.`Protocol` where Underlying == UInt8 {

    @inlinable
    public static var ascii: ASCII.Namespace<Self>.Type {
        ASCII.Namespace<Self>.self
    }
}

extension ASCII {

    @frozen
    public enum Namespace<Owner: Carrier.`Protocol`> where Owner.Underlying == UInt8 {}
}

extension ASCII.Namespace {

    @inlinable public static var nul: Owner { Owner(0x00 as UInt8) }

    @inlinable public static var soh: Owner { Owner(0x01 as UInt8) }

    @inlinable public static var stx: Owner { Owner(0x02 as UInt8) }

    @inlinable public static var etx: Owner { Owner(0x03 as UInt8) }

    @inlinable public static var eot: Owner { Owner(0x04 as UInt8) }

    @inlinable public static var enq: Owner { Owner(0x05 as UInt8) }

    @inlinable public static var ack: Owner { Owner(0x06 as UInt8) }

    @inlinable public static var bel: Owner { Owner(0x07 as UInt8) }

    @inlinable public static var bs: Owner { Owner(0x08 as UInt8) }

    @inlinable public static var htab: Owner { Owner(0x09 as UInt8) }

    @inlinable public static var tab: Owner { Owner(0x09 as UInt8) }

    @inlinable public static var lf: Owner { Owner(0x0A as UInt8) }

    @inlinable public static var newline: Owner { Owner(0x0A as UInt8) }

    @inlinable public static var vtab: Owner { Owner(0x0B as UInt8) }

    @inlinable public static var ff: Owner { Owner(0x0C as UInt8) }

    @inlinable public static var cr: Owner { Owner(0x0D as UInt8) }

    @inlinable public static var so: Owner { Owner(0x0E as UInt8) }

    @inlinable public static var si: Owner { Owner(0x0F as UInt8) }

    @inlinable public static var dle: Owner { Owner(0x10 as UInt8) }

    @inlinable public static var dc1: Owner { Owner(0x11 as UInt8) }

    @inlinable public static var dc2: Owner { Owner(0x12 as UInt8) }

    @inlinable public static var dc3: Owner { Owner(0x13 as UInt8) }

    @inlinable public static var dc4: Owner { Owner(0x14 as UInt8) }

    @inlinable public static var nak: Owner { Owner(0x15 as UInt8) }

    @inlinable public static var syn: Owner { Owner(0x16 as UInt8) }

    @inlinable public static var etb: Owner { Owner(0x17 as UInt8) }

    @inlinable public static var can: Owner { Owner(0x18 as UInt8) }

    @inlinable public static var em: Owner { Owner(0x19 as UInt8) }

    @inlinable public static var sub: Owner { Owner(0x1A as UInt8) }

    @inlinable public static var esc: Owner { Owner(0x1B as UInt8) }

    @inlinable public static var fs: Owner { Owner(0x1C as UInt8) }

    @inlinable public static var gs: Owner { Owner(0x1D as UInt8) }

    @inlinable public static var rs: Owner { Owner(0x1E as UInt8) }

    @inlinable public static var us: Owner { Owner(0x1F as UInt8) }

    @inlinable public static var del: Owner { Owner(0x7F as UInt8) }
}

extension ASCII.Namespace {

    @inlinable public static var sp: Owner { Owner(0x20 as UInt8) }

    @inlinable public static var space: Owner { Owner(0x20 as UInt8) }
}

extension ASCII.Namespace {

    @inlinable public static var exclamationPoint: Owner { Owner(0x21 as UInt8) }

    @inlinable public static var quotationMark: Owner { Owner(0x22 as UInt8) }

    @inlinable public static var dquote: Owner { Owner(0x22 as UInt8) }

    @inlinable public static var doubleQuote: Owner { Owner(0x22 as UInt8) }

    @inlinable public static var numberSign: Owner { Owner(0x23 as UInt8) }

    @inlinable public static var dollarSign: Owner { Owner(0x24 as UInt8) }

    @inlinable public static var percentSign: Owner { Owner(0x25 as UInt8) }

    @inlinable public static var ampersand: Owner { Owner(0x26 as UInt8) }

    @inlinable public static var apostrophe: Owner { Owner(0x27 as UInt8) }

    @inlinable public static var leftParenthesis: Owner { Owner(0x28 as UInt8) }

    @inlinable public static var rightParenthesis: Owner { Owner(0x29 as UInt8) }

    @inlinable public static var asterisk: Owner { Owner(0x2A as UInt8) }

    @inlinable public static var plusSign: Owner { Owner(0x2B as UInt8) }

    @inlinable public static var plus: Owner { Owner(0x2B as UInt8) }

    @inlinable public static var comma: Owner { Owner(0x2C as UInt8) }

    @inlinable public static var hyphen: Owner { Owner(0x2D as UInt8) }

    @inlinable public static var period: Owner { Owner(0x2E as UInt8) }

    @inlinable public static var slant: Owner { Owner(0x2F as UInt8) }

    @inlinable public static var solidus: Owner { Owner(0x2F as UInt8) }

    @inlinable public static var slash: Owner { Owner(0x2F as UInt8) }

    @inlinable public static var forwardSlash: Owner { Owner(0x2F as UInt8) }
}

extension ASCII.Namespace {

    @inlinable public static var `0`: Owner { Owner(0x30 as UInt8) }

    @inlinable public static var `1`: Owner { Owner(0x31 as UInt8) }

    @inlinable public static var `2`: Owner { Owner(0x32 as UInt8) }

    @inlinable public static var `3`: Owner { Owner(0x33 as UInt8) }

    @inlinable public static var `4`: Owner { Owner(0x34 as UInt8) }

    @inlinable public static var `5`: Owner { Owner(0x35 as UInt8) }

    @inlinable public static var `6`: Owner { Owner(0x36 as UInt8) }

    @inlinable public static var `7`: Owner { Owner(0x37 as UInt8) }

    @inlinable public static var `8`: Owner { Owner(0x38 as UInt8) }

    @inlinable public static var `9`: Owner { Owner(0x39 as UInt8) }
}

extension ASCII.Namespace {

    @inlinable public static var colon: Owner { Owner(0x3A as UInt8) }

    @inlinable public static var semicolon: Owner { Owner(0x3B as UInt8) }

    @inlinable public static var lessThanSign: Owner { Owner(0x3C as UInt8) }

    @inlinable public static var lt: Owner { Owner(0x3C as UInt8) }

    @inlinable public static var lessThan: Owner { Owner(0x3C as UInt8) }

    @inlinable public static var equalsSign: Owner { Owner(0x3D as UInt8) }

    @inlinable public static var greaterThanSign: Owner { Owner(0x3E as UInt8) }

    @inlinable public static var gt: Owner { Owner(0x3E as UInt8) }

    @inlinable public static var greaterThan: Owner { Owner(0x3E as UInt8) }

    @inlinable public static var questionMark: Owner { Owner(0x3F as UInt8) }

    @inlinable public static var commercialAt: Owner { Owner(0x40 as UInt8) }

    @inlinable public static var at: Owner { Owner(0x40 as UInt8) }

    @inlinable public static var atSign: Owner { Owner(0x40 as UInt8) }
}

extension ASCII.Namespace {

    @inlinable public static var A: Owner { Owner(0x41 as UInt8) }

    @inlinable public static var B: Owner { Owner(0x42 as UInt8) }

    @inlinable public static var C: Owner { Owner(0x43 as UInt8) }

    @inlinable public static var D: Owner { Owner(0x44 as UInt8) }

    @inlinable public static var E: Owner { Owner(0x45 as UInt8) }

    @inlinable public static var F: Owner { Owner(0x46 as UInt8) }

    @inlinable public static var G: Owner { Owner(0x47 as UInt8) }

    @inlinable public static var H: Owner { Owner(0x48 as UInt8) }

    @inlinable public static var I: Owner { Owner(0x49 as UInt8) }

    @inlinable public static var J: Owner { Owner(0x4A as UInt8) }

    @inlinable public static var K: Owner { Owner(0x4B as UInt8) }

    @inlinable public static var L: Owner { Owner(0x4C as UInt8) }

    @inlinable public static var M: Owner { Owner(0x4D as UInt8) }

    @inlinable public static var N: Owner { Owner(0x4E as UInt8) }

    @inlinable public static var O: Owner { Owner(0x4F as UInt8) }

    @inlinable public static var P: Owner { Owner(0x50 as UInt8) }

    @inlinable public static var Q: Owner { Owner(0x51 as UInt8) }

    @inlinable public static var R: Owner { Owner(0x52 as UInt8) }

    @inlinable public static var S: Owner { Owner(0x53 as UInt8) }

    @inlinable public static var T: Owner { Owner(0x54 as UInt8) }

    @inlinable public static var U: Owner { Owner(0x55 as UInt8) }

    @inlinable public static var V: Owner { Owner(0x56 as UInt8) }

    @inlinable public static var W: Owner { Owner(0x57 as UInt8) }

    @inlinable public static var X: Owner { Owner(0x58 as UInt8) }

    @inlinable public static var Y: Owner { Owner(0x59 as UInt8) }

    @inlinable public static var Z: Owner { Owner(0x5A as UInt8) }
}

extension ASCII.Namespace {

    @inlinable public static var leftBracket: Owner { Owner(0x5B as UInt8) }

    @inlinable public static var leftSquareBracket: Owner { Owner(0x5B as UInt8) }

    @inlinable public static var reverseSlant: Owner { Owner(0x5C as UInt8) }

    @inlinable public static var reverseSolidus: Owner { Owner(0x5C as UInt8) }

    @inlinable public static var backslash: Owner { Owner(0x5C as UInt8) }

    @inlinable public static var rightBracket: Owner { Owner(0x5D as UInt8) }

    @inlinable public static var rightSquareBracket: Owner { Owner(0x5D as UInt8) }

    @inlinable public static var circumflexAccent: Owner { Owner(0x5E as UInt8) }

    @inlinable public static var underline: Owner { Owner(0x5F as UInt8) }

    @inlinable public static var leftSingleQuotationMark: Owner { Owner(0x60 as UInt8) }
}

extension ASCII.Namespace {

    @inlinable public static var a: Owner { Owner(0x61 as UInt8) }

    @inlinable public static var b: Owner { Owner(0x62 as UInt8) }

    @inlinable public static var c: Owner { Owner(0x63 as UInt8) }

    @inlinable public static var d: Owner { Owner(0x64 as UInt8) }

    @inlinable public static var e: Owner { Owner(0x65 as UInt8) }

    @inlinable public static var f: Owner { Owner(0x66 as UInt8) }

    @inlinable public static var g: Owner { Owner(0x67 as UInt8) }

    @inlinable public static var h: Owner { Owner(0x68 as UInt8) }

    @inlinable public static var i: Owner { Owner(0x69 as UInt8) }

    @inlinable public static var j: Owner { Owner(0x6A as UInt8) }

    @inlinable public static var k: Owner { Owner(0x6B as UInt8) }

    @inlinable public static var l: Owner { Owner(0x6C as UInt8) }

    @inlinable public static var m: Owner { Owner(0x6D as UInt8) }

    @inlinable public static var n: Owner { Owner(0x6E as UInt8) }

    @inlinable public static var o: Owner { Owner(0x6F as UInt8) }

    @inlinable public static var p: Owner { Owner(0x70 as UInt8) }

    @inlinable public static var q: Owner { Owner(0x71 as UInt8) }

    @inlinable public static var r: Owner { Owner(0x72 as UInt8) }

    @inlinable public static var s: Owner { Owner(0x73 as UInt8) }

    @inlinable public static var t: Owner { Owner(0x74 as UInt8) }

    @inlinable public static var u: Owner { Owner(0x75 as UInt8) }

    @inlinable public static var v: Owner { Owner(0x76 as UInt8) }

    @inlinable public static var w: Owner { Owner(0x77 as UInt8) }

    @inlinable public static var x: Owner { Owner(0x78 as UInt8) }

    @inlinable public static var y: Owner { Owner(0x79 as UInt8) }

    @inlinable public static var z: Owner { Owner(0x7A as UInt8) }
}

extension ASCII.Namespace {

    @inlinable public static var leftBrace: Owner { Owner(0x7B as UInt8) }

    @inlinable public static var verticalLine: Owner { Owner(0x7C as UInt8) }

    @inlinable public static var rightBrace: Owner { Owner(0x7D as UInt8) }

    @inlinable public static var tilde: Owner { Owner(0x7E as UInt8) }
}
