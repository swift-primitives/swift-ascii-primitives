extension ASCII {

    public enum Line {}
}

extension ASCII.Line {

    public enum Ending: Sendable {

        case lf

        case cr

        case crlf
    }
}
