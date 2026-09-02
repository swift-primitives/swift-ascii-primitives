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

extension ASCII.Decimal {

    @inlinable
    public static func serialize<
        T: FixedWidthInteger & UnsignedInteger,
        Buffer: RangeReplaceableCollection
    >(
        _ value: T,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        if value == 0 {
            buffer.append(Byte(bitPattern: ASCII.Character.Graphic.`0`))
            return
        }

        var n = value
        let capacity = T.bitWidth / 3 + 2
        var count = 0

        withUnsafeTemporaryAllocation(of: UInt8.self, capacity: capacity) { scratch in

            while n > 0 {
                unsafe (scratch[count] = ASCII.Character.Graphic.`0` + UInt8(n % 10))
                n /= 10
                count += 1
            }

            (0..<count).reversed().forEach { i in
                unsafe buffer.append(Byte(bitPattern: scratch[i]))
            }
        }
    }

    @inlinable
    public static func serialize<
        T: FixedWidthInteger & SignedInteger,
        Buffer: RangeReplaceableCollection
    >(
        _ value: T,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        if value == 0 {
            buffer.append(Byte(bitPattern: ASCII.Character.Graphic.`0`))
            return
        }

        if value < 0 {
            buffer.append(Byte(bitPattern: ASCII.Character.Graphic.hyphen))
        }
        var n = value.magnitude

        let capacity = T.bitWidth / 3 + 2
        var count = 0

        withUnsafeTemporaryAllocation(of: UInt8.self, capacity: capacity) { scratch in

            while n > 0 {
                unsafe (scratch[count] = ASCII.Character.Graphic.`0` + UInt8(n % 10))
                n /= 10
                count += 1
            }

            (0..<count).reversed().forEach { i in
                unsafe buffer.append(Byte(bitPattern: scratch[i]))
            }
        }
    }

}
