extension ASCII {

    @frozen
    public struct Code: Sendable {

        public let underlying: UInt8

        @inlinable
        public init(_ underlying: consuming UInt8) {
            self.underlying = underlying
        }
    }
}
