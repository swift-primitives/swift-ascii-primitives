import ASCII_Primitives
import ASCII_Primitives_Standard_Library_Integration
import Testing

@Suite("ASCII Classification UInt8 forwarders")
struct ASCII_Classification_UInt8_Tests {
    @Test
    func `isAllWhitespace forwarder matches primary on whitespace [UInt8]`() {
        let uint8s: [UInt8] = [0x20, 0x09, 0x0A, 0x0D]
        #expect(ASCII.Classification.isAllWhitespace(uint8s))
    }

    @Test
    func `isAllWhitespace forwarder rejects mixed content`() {
        let uint8s: [UInt8] = [0x20, 0x41]
        #expect(!ASCII.Classification.isAllWhitespace(uint8s))
    }

    @Test
    func `isAllDigits forwarder matches primary on digit [UInt8]`() {
        let uint8s: [UInt8] = Array("01234".utf8)
        #expect(ASCII.Classification.isAllDigits(uint8s))
    }

    @Test
    func `isAllDigits forwarder rejects non-digit`() {
        let uint8s: [UInt8] = Array("01A2".utf8)
        #expect(!ASCII.Classification.isAllDigits(uint8s))
    }

    @Test
    func `isAllLetters forwarder matches primary on letter [UInt8]`() {
        let uint8s: [UInt8] = Array("Hello".utf8)
        #expect(ASCII.Classification.isAllLetters(uint8s))
    }

    @Test
    func `isAllLetters forwarder rejects digit`() {
        let uint8s: [UInt8] = Array("Hello1".utf8)
        #expect(!ASCII.Classification.isAllLetters(uint8s))
    }

    @Test
    func `isAllAlphanumeric forwarder matches primary on alphanumeric [UInt8]`() {
        let uint8s: [UInt8] = Array("abc123".utf8)
        #expect(ASCII.Classification.isAllAlphanumeric(uint8s))
    }

    @Test
    func `isAllAlphanumeric forwarder rejects punctuation`() {
        let uint8s: [UInt8] = Array("abc!".utf8)
        #expect(!ASCII.Classification.isAllAlphanumeric(uint8s))
    }

    @Test
    func `isAllControl forwarder matches primary on control [UInt8]`() {
        let uint8s: [UInt8] = [0x00, 0x01, 0x1F, 0x7F]
        #expect(ASCII.Classification.isAllControl(uint8s))
    }

    @Test
    func `isAllControl forwarder rejects printable`() {
        let uint8s: [UInt8] = [0x00, 0x41]
        #expect(!ASCII.Classification.isAllControl(uint8s))
    }

    @Test
    func `isAllVisible forwarder matches primary on visible [UInt8]`() {
        let uint8s: [UInt8] = Array("Hello!".utf8)
        #expect(ASCII.Classification.isAllVisible(uint8s))
    }

    @Test
    func `isAllVisible forwarder rejects space`() {
        let uint8s: [UInt8] = Array("Hi there".utf8)
        #expect(!ASCII.Classification.isAllVisible(uint8s))
    }

    @Test
    func `isAllPrintable forwarder matches primary on printable [UInt8]`() {
        let uint8s: [UInt8] = Array("Hello World".utf8)
        #expect(ASCII.Classification.isAllPrintable(uint8s))
    }

    @Test
    func `isAllPrintable forwarder rejects control`() {
        let uint8s: [UInt8] = Array("Hi\u{0001}".utf8)
        #expect(!ASCII.Classification.isAllPrintable(uint8s))
    }

    @Test
    func `isAllLowercase forwarder matches primary on lowercase [UInt8]`() {
        let uint8s: [UInt8] = Array("hello".utf8)
        #expect(ASCII.Classification.isAllLowercase(uint8s))
    }

    @Test
    func `isAllLowercase forwarder rejects uppercase`() {
        let uint8s: [UInt8] = Array("Hello".utf8)
        #expect(!ASCII.Classification.isAllLowercase(uint8s))
    }

    @Test
    func `isAllUppercase forwarder matches primary on uppercase [UInt8]`() {
        let uint8s: [UInt8] = Array("HELLO".utf8)
        #expect(ASCII.Classification.isAllUppercase(uint8s))
    }

    @Test
    func `isAllUppercase forwarder rejects lowercase`() {
        let uint8s: [UInt8] = Array("Hello".utf8)
        #expect(!ASCII.Classification.isAllUppercase(uint8s))
    }

    @Test
    func `containsNonASCII forwarder fires on high byte`() {
        let uint8s: [UInt8] = [0x41, 0x80]
        #expect(ASCII.Classification.containsNonASCII(uint8s))
    }

    @Test
    func `containsNonASCII forwarder skips ASCII-only`() {
        let uint8s: [UInt8] = Array("Hello".utf8)
        #expect(!ASCII.Classification.containsNonASCII(uint8s))
    }

    @Test
    func `containsHexDigit forwarder fires on hex digit`() {
        let uint8s: [UInt8] = Array("xyzA".utf8)
        #expect(ASCII.Classification.containsHexDigit(uint8s))
    }

    @Test
    func `containsHexDigit forwarder rejects non-hex letters`() {
        let uint8s: [UInt8] = Array("xyz".utf8)
        #expect(!ASCII.Classification.containsHexDigit(uint8s))
    }
}
