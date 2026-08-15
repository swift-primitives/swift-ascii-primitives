// ASCII.Code+Byte.Protocol.swift
// swift-ascii-primitives
//
// ASCII.Code's conformance to Byte.`Protocol` — the per-domain
// capability marker from swift-byte-primitives.
//
// Per [API-NAME-001c]'s sibling-form recipe, ASCII.Code is a peer
// byte-domain conformer alongside `Byte` itself (NOT a Tagged-phantom-
// wrapping of Byte). The conformance is direct: ASCII.Code projects to
// `byte: Byte { Byte(underlying) }` and injects via `init(_ byte: Byte)
// throws(Error)`.
//
// Domain = Never — bare ASCII.Code is unscoped (consumers wanting
// phantom-tagging form `Tagged<Domain, ASCII.Code>`, which inherits
// Byte.Protocol via the recursive `Tagged: Byte.Protocol where
// Underlying: Byte.Protocol, Tag: ~Copyable` extension in
// swift-byte-primitives).
//
// Error = ASCII.Code.Error — refined-domain conformer (the valid
// subset is 0x00–0x7F, not all Byte values). Triggers the typed-throws
// path of `Byte.\`Protocol\`.init(_ byte: Byte) throws(Self.Error)`.
//
// Since `Error != Never`, the universal-domain defaults (`zero`, `max`,
// `init(integerLiteral:)`, bitwise operators) from Byte.`Protocol`'s
// extensions are inapplicable here — this file provides ASCII.Code's
// own. Notably, `max` is `.del` (0x7F), NOT 0xFF — the default would
// silently store an out-of-range value.
//
// Stdlib conformances (Equatable, Hashable, Comparable,
// ExpressibleByIntegerLiteral) are declared separately on ASCII.Code per
// [API-NAME-001c]; their witnesses come from Byte.`Protocol`'s default-
// impl extension (==, hash(into:), <) plus the per-conformer
// `init(integerLiteral:)` below.

public import Byte_Primitives

extension ASCII.Code: Byte.`Protocol` {
    /// Bare ASCII.Code is unscoped.
    public typealias Domain = Never

    /// Associated-type witness for `Byte.\`Protocol\`.Error` resolves to
    /// the nested `ASCII.Code.Error` enum (declared in
    /// `ASCII.Code.Error.swift`) by name-lookup of the throws clause on
    /// `init(_:)` below — no explicit `typealias Error = ...` is
    /// declared here because that would conflict with the nested-enum
    /// name in `ASCII.Code`'s scope (Swift rejects member duplication
    /// across typealias and nested type).

    /// The byte that this ASCII code carries.
    @inlinable
    public var byte: Byte { Byte(underlying) }

    /// Creates an ASCII code from a byte value, validating that it is in
    /// the 7-bit ASCII range (0x00–0x7F).
    ///
    /// Throws `ASCII.Code.Error.notASCII` if `byte.underlying >= 0x80`.
    /// For unchecked construction (when the caller already has a type-
    /// or invariant-level guarantee that `byte` is in range), use
    /// ``init(unchecked:)``.
    @inlinable
    public init(_ byte: Byte) throws(Self.Error) {
        guard byte.underlying < 0x80 else { throw .notASCII(byte: byte) }
        self.init(byte.underlying)
    }

    /// Creates an ASCII code from a byte value WITHOUT validation.
    ///
    /// Use only when the caller already has a guarantee that `byte` is
    /// in the 7-bit ASCII range (e.g., a value produced by an earlier
    /// successful ASCII.Code lift, or a compile-time constant the
    /// reader can verify). For unverified bytes, prefer the throwing
    /// ``init(_:)``.
    @inlinable
    public init(unchecked byte: Byte) {
        self.init(byte.underlying)
    }
}

// MARK: - Universal-Domain Defaults Provided By Conformer
//
// Byte.`Protocol`'s extensions gate `zero` / `max` / `init(integerLiteral:)`
// behind `where Error == Never`. ASCII.Code (Error == ASCII.Code.Error)
// must supply its own — and the values differ semantically:
//
// - `zero` is 0x00 (NUL) — same as the universal default
// - `max` is 0x7F (DEL) — NOT 0xFF; the universal default would lift
//   an invalid byte
// - `init(integerLiteral:)` validates with `precondition` since
//   `ExpressibleByIntegerLiteral` cannot throw

extension ASCII.Code {
    /// The ASCII code with all bits cleared (`0x00`, NUL).
    @inlinable
    public static var zero: ASCII.Code { ASCII.Code(unchecked: Byte(0x00)) }

    /// The highest ASCII code (`0x7F`, DEL).
    ///
    /// Note this is `0x7F`, not `0xFF` — ASCII.Code's valid range caps
    /// at 7 bits. The universal `Byte.\`Protocol\`.max == 0xFF` default
    /// is inapplicable; using it would silently store an out-of-range
    /// value.
    @inlinable
    public static var max: ASCII.Code { ASCII.Code(unchecked: Byte(0x7F)) }
}

extension ASCII.Code: ExpressibleByIntegerLiteral {
    /// Creates an ASCII code from an integer literal.
    ///
    /// Traps if the literal is not in the 7-bit ASCII range (0x00–0x7F).
    /// `ExpressibleByIntegerLiteral` is not throwing-capable, so range
    /// violations are caught at construction via `precondition` rather
    /// than propagated as a typed throw. For runtime-discovered byte
    /// values, use the throwing ``init(_:)``.
    ///
    /// `@_disfavoredOverload` keeps this literal initializer from competing with
    /// the designated `init(_ underlying: UInt8)` when `ASCII.Code.init` is used
    /// as a bare function reference (e.g. `bytes.map(ASCII.Code.init)`): both
    /// accept a single `UInt8`, so without disfavoring this one the reference is
    /// ambiguous. Integer-literal construction (`let c: ASCII.Code = 0x41`) is
    /// unaffected — literal conversion always selects this witness. ([CONV-007])
    @_disfavoredOverload
    @inlinable
    public init(integerLiteral value: UInt8.IntegerLiteralType) {
        let u = UInt8(integerLiteral: value)
        precondition(
            u < 0x80,
            "ASCII.Code integer literal must be in 0x00...0x7F (got 0x\(String(u, radix: 16)))"
        )
        self.init(unchecked: Byte(u))
    }
}

// MARK: - ASCII.Code Stdlib Conformances
//
// Equatable / Hashable / Comparable witnesses come from
// Byte.`Protocol`'s default-impl extension (==, hash(into:), <).

extension ASCII.Code: Equatable {}
extension ASCII.Code: Hashable {}
extension ASCII.Code: Comparable {}

// MARK: - ASCII-Range-Preserving Bitwise Operations
//
// Byte.`Protocol`'s bitwise defaults are gated `where Error == Never`.
// ASCII.Code provides its own for the operations whose result is
// guaranteed to stay in the 7-bit ASCII range.
//
// Safe to provide (high bit of inputs is 0, output high bit is 0):
//   - `&` — AND of two ASCII.Code values: all output bits ≤ input bits
//   - `|` — OR of two ASCII.Code values: each output bit is OR of
//     two input bits whose high positions are 0; output high stays 0
//   - `^` — XOR of two ASCII.Code values: each output bit is XOR of
//     two input bits; XOR of two 0-bits is 0; output high stays 0
//
// Deliberately NOT provided (would leave the ASCII range):
//   - `~` — complement flips the high bit (0 → 1), result NOT in
//     0x00–0x7F. Consumer must drop to `.underlying`, complement,
//     then `try ASCII.Code(_:)`.
//   - `<<` — left shift can push bits into the high position
//     (e.g., `ASCII.Code(0x40) << 1 == 0x80`, invalid).
//   - `>>` — right shift IS safe (result ≤ input, still ASCII), but
//     omitted here to keep the ASCII.Code bitwise surface minimal.
//     Consumers can bridge through `.underlying` if needed.

extension ASCII.Code {
    /// Bitwise AND of two ASCII codes — result is guaranteed in 0x00–0x7F.
    @inlinable
    public static func & (lhs: ASCII.Code, rhs: ASCII.Code) -> ASCII.Code {
        ASCII.Code(unchecked: Byte(lhs.underlying & rhs.underlying))
    }

    /// Bitwise OR of two ASCII codes — result is guaranteed in 0x00–0x7F.
    @inlinable
    public static func | (lhs: ASCII.Code, rhs: ASCII.Code) -> ASCII.Code {
        ASCII.Code(unchecked: Byte(lhs.underlying | rhs.underlying))
    }

    /// Bitwise XOR of two ASCII codes — result is guaranteed in 0x00–0x7F.
    @inlinable
    public static func ^ (lhs: ASCII.Code, rhs: ASCII.Code) -> ASCII.Code {
        ASCII.Code(unchecked: Byte(lhs.underlying ^ rhs.underlying))
    }

    /// Bitwise AND assignment.
    @inlinable
    public static func &= (lhs: inout ASCII.Code, rhs: ASCII.Code) {
        lhs = lhs & rhs
    }

    /// Bitwise OR assignment.
    @inlinable
    public static func |= (lhs: inout ASCII.Code, rhs: ASCII.Code) {
        lhs = lhs | rhs
    }

    /// Bitwise XOR assignment.
    @inlinable
    public static func ^= (lhs: inout ASCII.Code, rhs: ASCII.Code) {
        lhs = lhs ^ rhs
    }
}
