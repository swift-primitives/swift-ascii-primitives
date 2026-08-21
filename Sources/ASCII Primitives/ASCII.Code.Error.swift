public import Byte_Primitives

extension ASCII.Code {

    public enum Error: Swift.Error, Equatable, Sendable {

        case notASCII(byte: Byte)
    }
}
