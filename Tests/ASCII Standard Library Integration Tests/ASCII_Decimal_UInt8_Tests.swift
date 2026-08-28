import ASCII
import ASCII_Standard_Library_Integration
import Testing

@Suite("ASCII Decimal UInt8 forwarders")
struct ASCII_Decimal_UInt8_Tests {
    @Test
    func `serialize UnsignedInteger forwarder writes ASCII digits`() {
        var buffer: [UInt8] = []
        ASCII.Decimal.serialize(UInt(42), into: &buffer)
        #expect(buffer == [0x34, 0x32])
    }

    @Test
    func `serialize UnsignedInteger forwarder handles zero`() {
        var buffer: [UInt8] = []
        ASCII.Decimal.serialize(UInt(0), into: &buffer)
        #expect(buffer == [0x30])
    }

    @Test
    func `serialize UnsignedInteger forwarder handles max UInt64`() {
        var buffer: [UInt8] = []
        ASCII.Decimal.serialize(UInt64.max, into: &buffer)
        #expect(buffer == Array("18446744073709551615".utf8))
    }

    @Test
    func `serialize SignedInteger forwarder writes negative ASCII`() {
        var buffer: [UInt8] = []
        ASCII.Decimal.serialize(Int(-42), into: &buffer)
        #expect(buffer == [0x2D, 0x34, 0x32])
    }

    @Test
    func `serialize SignedInteger forwarder writes positive ASCII`() {
        var buffer: [UInt8] = []
        ASCII.Decimal.serialize(Int(42), into: &buffer)
        #expect(buffer == [0x34, 0x32])
    }

    @Test
    func `serialize SignedInteger forwarder handles zero`() {
        var buffer: [UInt8] = []
        ASCII.Decimal.serialize(Int(0), into: &buffer)
        #expect(buffer == [0x30])
    }

    @Test
    func `serialize SignedInteger forwarder appends to existing buffer`() {
        var buffer: [UInt8] = [0x58]
        ASCII.Decimal.serialize(Int(7), into: &buffer)
        #expect(buffer == [0x58, 0x37])
    }
}
