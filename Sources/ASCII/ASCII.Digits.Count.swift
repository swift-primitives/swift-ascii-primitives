extension ASCII.Digits {

    public enum Count: Sendable, Equatable {

        case greedy

        case exactly(Int)

        case atMost(Int)
    }
}
