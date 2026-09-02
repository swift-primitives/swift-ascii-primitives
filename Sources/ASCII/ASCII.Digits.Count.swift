extension ASCII.Digits {

    public enum Count: Equatable {

        case greedy

        case exactly(Int)

        case atMost(Int)
    }
}
