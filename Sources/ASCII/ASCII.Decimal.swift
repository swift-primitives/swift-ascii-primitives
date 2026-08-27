extension ASCII {

    public enum Decimal {}
}

extension ASCII.Decimal {

    @inlinable
    public static func code(_ value: UInt8) -> ASCII.Code? {
        guard value <= 9 else { return nil }
        return ASCII.Code(ASCII.Character.Graphic.`0` + value)
    }
}
