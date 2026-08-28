public import Byte

extension ASCII.Code {

    public enum Error: Swift.Error, Equatable, Sendable {

        case notASCII(byte: Byte)
    }
}
