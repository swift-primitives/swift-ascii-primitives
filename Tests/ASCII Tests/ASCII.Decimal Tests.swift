import ASCII
import Byte
import Testing

extension ASCII.Decimal {
    @Suite("ASCII.Decimal")
    struct Tests {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
    }
}

extension ASCII.Decimal.Tests.`Edge Case` {

    @Test
    func
        `serialize UInt128 value with 21 decimal digits does not overflow the legacy 20 byte buffer`()
    {

        let value: UInt128 = 100_000_000_000_000_000_000
        var buffer: [Byte] = []
        ASCII.Decimal.serialize(value, into: &buffer)
        let expected = Array("100000000000000000000".utf8).map(Byte.init)
        #expect(buffer == expected)
    }

    @Test
    func `serialize UInt128 max writes all 39 decimal digits`() {
        var buffer: [Byte] = []
        ASCII.Decimal.serialize(UInt128.max, into: &buffer)
        let expected = Array("340282366920938463463374607431768211455".utf8).map(Byte.init)
        #expect(buffer == expected)
    }

    @Test
    func `serialize Int128 max writes all 39 decimal digits`() {
        var buffer: [Byte] = []
        ASCII.Decimal.serialize(Int128.max, into: &buffer)
        let expected = Array("170141183460469231731687303715884105727".utf8).map(Byte.init)
        #expect(buffer == expected)
    }

    @Test
    func `serialize Int128 min writes magnitude without trapping`() {
        var buffer: [Byte] = []
        ASCII.Decimal.serialize(Int128.min, into: &buffer)
        let expected = Array("-170141183460469231731687303715884105728".utf8).map(Byte.init)
        #expect(buffer == expected)
    }

    @Test
    func `serialize Int8 min does not trap`() {
        var buffer: [Byte] = []
        ASCII.Decimal.serialize(Int8.min, into: &buffer)
        #expect(buffer == Array("-128".utf8).map(Byte.init))
    }

    @Test
    func `serialize Int min does not trap`() {
        var buffer: [Byte] = []
        ASCII.Decimal.serialize(Int.min, into: &buffer)
        #expect(buffer == Array("-9223372036854775808".utf8).map(Byte.init))
    }

    @Test
    func `serialize Int64 min does not trap`() {
        var buffer: [Byte] = []
        ASCII.Decimal.serialize(Int64.min, into: &buffer)
        #expect(buffer == Array("-9223372036854775808".utf8).map(Byte.init))
    }
}
