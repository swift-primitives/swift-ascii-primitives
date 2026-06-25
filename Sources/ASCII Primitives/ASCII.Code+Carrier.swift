// ASCII.Code+Carrier.swift
// swift-ascii-primitives
//
// ASCII.Code conforms to Carrier.`Protocol` with Underlying == UInt8 —
// the carrier-axis conformance, separate from the byte-domain-axis
// Byte.`Protocol` conformance in ASCII.Code+Byte.Protocol.swift.
//
// These two conformances are sibling axes, mirroring `Byte` itself:
//
//   - Carrier.`Protocol`<UInt8>: cross-type generic dispatch over any
//     UInt8-carrying value. Includes ASCII.Code, Byte, future UInt8-
//     carrying newtypes, and (via trivial-self-carrier in swift-carrier-
//     primitives' standard-library integration) UInt8 itself.
//   - Byte.`Protocol`: byte-domain ergonomics. Conformers project to
//     `byte: Byte`. Does NOT include UInt8 (UInt8 is the arithmetic twin).
//
// See `swift-byte-primitives/Sources/Byte Primitives/Byte+Carrier.swift`
// for the full design rationale and the recursion-vs-refinement
// constraint principle.

public import Carrier_Primitives

// MARK: - Carrier.`Protocol` Conformance

extension ASCII.Code: Carrier.`Protocol` {
    /// ASCII.Code carries a `UInt8`.
    public typealias Underlying = UInt8

    // `Domain` defaults to `Never` per the Carrier protocol declaration.
    //
    // The Carrier-required `var underlying: UInt8 { borrowing get }` is
    // satisfied by ASCII.Code's stored `public let underlying: UInt8`
    // field declared in ASCII.Code.swift.
    //
    // The Carrier-required `init(_ underlying: consuming UInt8)` is
    // satisfied by ASCII.Code's existing same-shape initializer declared
    // in ASCII.Code.swift.
}
