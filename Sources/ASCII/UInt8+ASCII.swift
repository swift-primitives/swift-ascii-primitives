extension UInt8 {

    public static var ascii: ASCII.Code.Type {
        ASCII.Code.self
    }

    public var ascii: ASCII.Code {
        ASCII.Code(self)
    }
}
