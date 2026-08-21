public enum ASCII {}

extension ASCII {

    public enum Character {}
}

extension ASCII {

    public enum Case: Sendable {

        case upper

        case lower
    }
}

extension ASCII {

    public static let whitespaces: Set<ASCII.Code> = [
        .sp,
        .htab,
        .lf,
        .cr,
    ]
}
