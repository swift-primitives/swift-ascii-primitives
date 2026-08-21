extension ASCII {

    public enum Hexadecimal {}
}

extension ASCII.Hexadecimal {

    @inlinable
    public static func code(_ value: UInt8, `case`: ASCII.Case = .upper) -> ASCII.Code? {
        switch value {
        case 0...9:
            return ASCII.Code(ASCII.Character.Graphic.`0` + value)

        case 10...15:
            switch `case` {
            case .upper:
                return ASCII.Code(ASCII.Character.Graphic.A + value - 10)

            case .lower:
                return ASCII.Code(ASCII.Character.Graphic.a + value - 10)
            }

        default:
            return nil
        }
    }
}
