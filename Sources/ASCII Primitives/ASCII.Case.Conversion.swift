extension ASCII.Case {

    public enum Conversion {}
}

extension ASCII.Case.Conversion {

    public static let offset: UInt8 = 0x20
}

extension ASCII.Case.Conversion {

    @_transparent
    public static func convert(_ code: ASCII.Code, to case: ASCII.Case) -> ASCII.Code {
        let byte = code.underlying
        switch `case` {
        case .upper:

            let isLower = (byte &- 0x61) < 26
            return ASCII.Code(isLower ? byte &- 0x20 : byte)

        case .lower:

            let isUpper = (byte &- 0x41) < 26
            return ASCII.Code(isUpper ? byte &+ 0x20 : byte)
        }
    }
}

extension ASCII {

    @inlinable
    public static func convert<C: Swift.Collection>(
        _ codes: C,
        to case: ASCII.Case
    ) -> [ASCII.Code] where C.Element == Self.Code {
        var result = [Self.Code]()
        result.reserveCapacity(codes.count)

        switch `case` {
        case .upper:
            for code in codes {
                let byte = code.underlying
                let isLower = (byte &- 0x61) < 26
                result.append(Self.Code(isLower ? byte &- 0x20 : byte))
            }

        case .lower:
            for code in codes {
                let byte = code.underlying
                let isUpper = (byte &- 0x41) < 26
                result.append(Self.Code(isUpper ? byte &+ 0x20 : byte))
            }
        }

        return result
    }

    @inlinable
    public static func convert<S: StringProtocol>(_ string: S, to case: ASCII.Case) -> S {

        let convertedCodes = convert(string.utf8.map { Self.Code(unchecked: Byte($0)) }, to: `case`)
        return S(decoding: convertedCodes.map(\.underlying), as: UTF8.self)
    }
}
