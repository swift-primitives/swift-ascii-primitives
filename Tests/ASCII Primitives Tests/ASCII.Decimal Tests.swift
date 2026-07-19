// ASCII.Decimal Tests.swift
// swift-ascii-primitives
//
// Regression coverage for F-001 (ASCII.Decimal.serialize stack buffer
// overflow for arbitrary-width FixedWidthInteger).

import ASCII_Primitives
import Byte_Primitives
import Testing

extension ASCII.Decimal {
    @Suite("ASCII.Decimal")
    struct Tests {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
    }
}

extension ASCII.Decimal.Tests.`Edge Case` {

    // F-001: `serialize` wrote decimal digits into a fixed 20-byte stack
    // tuple regardless of the generic `T`'s bit width. UInt64.max needs
    // exactly 20 digits (the tuple's original sizing rationale), but
    // UInt128/Int128 can require up to 39 — every digit past the 20th
    // wrote outside the tuple's raw memory, a stack buffer overflow. These
    // cases pin the boundary the old fixed-size buffer could not cover.

    @Test
    func `serialize UInt128 value with 21 decimal digits does not overflow the legacy 20 byte buffer`() {
        // 10^20 is the first UInt128 magnitude requiring 21 digits — one
        // past the old tuple's exact 20-slot capacity.
        let value: UInt128 = 100_000_000_000_000_000_000
        var buffer: [Byte] = []
        ASCII.Decimal.serialize(value, into: &buffer)
        let expected = Array("100000000000000000000".utf8).map(Byte.init)
        #expect(buffer == expected)
    }

    @Test
    func `serialize UInt128 max writes all 39 decimal digits`() {
        var buffer: [Byte] = []
        ASCII.Decimal.serialize(UInt128.max, into: &buffer)
        let expected = Array("340282366920938463463374607431768211455".utf8).map(Byte.init)
        #expect(buffer == expected)
    }

    @Test
    func `serialize Int128 max writes all 39 decimal digits`() {
        var buffer: [Byte] = []
        ASCII.Decimal.serialize(Int128.max, into: &buffer)
        let expected = Array("170141183460469231731687303715884105727".utf8).map(Byte.init)
        #expect(buffer == expected)
    }
}
