// exports.swift
// swift-ascii-primitives
//
// Re-exports byte-domain dependencies so consumers importing ASCII_Primitives
// transitively pick up `Byte_Primitives` (for ASCII.Code's Byte.Protocol /
// Carrier.Protocol conformances and the Byte type) and
// `Byte_Primitives_Standard_Library_Integration` (for the Byte.Protocol-generic
// stdlib bridges — `String(_:radix:)`, `String(decoding:as:)`, `Character(_:)`,
// `Unicode.Scalar(_:)`, `Array<X: Byte.Protocol>(_:)`, etc.).

@_exported public import Byte_Primitives
@_exported public import Byte_Primitives_Standard_Library_Integration
