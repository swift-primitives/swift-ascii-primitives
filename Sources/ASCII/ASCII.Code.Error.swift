public import Byte

extension ASCII.Code {

    public enum Error: Swift.Error, Equatable {

        case notASCII(byte: Byte)
    }
}
