extension ASCII.Character {

    public enum Control {}
}

extension ASCII.Character.Control {

    public static let nul: UInt8 = 0x00
}

extension ASCII.Character.Control {

    public static let soh: UInt8 = 0x01

    public static let stx: UInt8 = 0x02

    public static let etx: UInt8 = 0x03

    public static let eot: UInt8 = 0x04

    public static let enq: UInt8 = 0x05

    public static let ack: UInt8 = 0x06

    public static let dle: UInt8 = 0x10

    public static let nak: UInt8 = 0x15

    public static let syn: UInt8 = 0x16

    public static let etb: UInt8 = 0x17
}

extension ASCII.Character.Control {

    public static let bs: UInt8 = 0x08

    public static let htab: UInt8 = 0x09

    public static let lf: UInt8 = 0x0A

    public static let vtab: UInt8 = 0x0B

    public static let ff: UInt8 = 0x0C

    public static let cr: UInt8 = 0x0D
}

extension ASCII.Character.Control {

    public static let so: UInt8 = 0x0E

    public static let si: UInt8 = 0x0F

    public static let esc: UInt8 = 0x1B
}

extension ASCII.Character.Control {

    public static let dc1: UInt8 = 0x11

    public static let dc2: UInt8 = 0x12

    public static let dc3: UInt8 = 0x13

    public static let dc4: UInt8 = 0x14
}

extension ASCII.Character.Control {

    public static let fs: UInt8 = 0x1C

    public static let gs: UInt8 = 0x1D

    public static let rs: UInt8 = 0x1E

    public static let us: UInt8 = 0x1F
}

extension ASCII.Character.Control {

    public static let bel: UInt8 = 0x07

    public static let can: UInt8 = 0x18

    public static let em: UInt8 = 0x19

    public static let sub: UInt8 = 0x1A

    public static let del: UInt8 = 0x7F
}

extension ASCII.Character.Control {

    public static let crlf: [UInt8] = [
        ASCII.Character.Control.cr,
        ASCII.Character.Control.lf,
    ]
}
