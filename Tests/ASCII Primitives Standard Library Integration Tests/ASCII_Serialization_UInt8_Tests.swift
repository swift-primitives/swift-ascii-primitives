import ASCII_Primitives
import ASCII_Primitives_Standard_Library_Integration
import Testing

@Suite("ASCII Serialization UInt8 forwarders")
struct ASCII_Serialization_UInt8_Tests {
    @Test
    func `serializeDecimal UnsignedInteger forwarder writes ASCII digits`() {
        var buffer: [UInt8] = []
        ASCII.Serialization.serializeDecimal(UInt(42), into: &buffer)
        #expect(buffer == [0x34, 0x32])
    }

    @Test
    func `serializeDecimal UnsignedInteger forwarder handles zero`() {
        var buffer: [UInt8] = []
        ASCII.Serialization.serializeDecimal(UInt(0), into: &buffer)
        #expect(buffer == [0x30])
    }

    @Test
    func `serializeDecimal UnsignedInteger forwarder handles max UInt64`() {
        var buffer: [UInt8] = []
        ASCII.Serialization.serializeDecimal(UInt64.max, into: &buffer)
        #expect(buffer == Array("18446744073709551615".utf8))
    }

    @Test
    func `serializeDecimal SignedInteger forwarder writes negative ASCII`() {
        var buffer: [UInt8] = []
        ASCII.Serialization.serializeDecimal(Int(-42), into: &buffer)
        #expect(buffer == [0x2D, 0x34, 0x32])
    }

    @Test
    func `serializeDecimal SignedInteger forwarder writes positive ASCII`() {
        var buffer: [UInt8] = []
        ASCII.Serialization.serializeDecimal(Int(42), into: &buffer)
        #expect(buffer == [0x34, 0x32])
    }

    @Test
    func `serializeDecimal SignedInteger forwarder handles zero`() {
        var buffer: [UInt8] = []
        ASCII.Serialization.serializeDecimal(Int(0), into: &buffer)
        #expect(buffer == [0x30])
    }

    @Test
    func `serializeDecimal SignedInteger forwarder appends to existing buffer`() {
        var buffer: [UInt8] = [0x58]
        ASCII.Serialization.serializeDecimal(Int(7), into: &buffer)
        #expect(buffer == [0x58, 0x37])
    }
}
