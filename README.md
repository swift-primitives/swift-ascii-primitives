# ASCII

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

ASCII types for Swift — a typed `ASCII.Code` carrier, the full INCITS 4-1986 character set as named constants, and byte-level classification, case-conversion, parsing, and serialization, with zero Foundation dependency.

---

## Quick Start

`ASCII.Code` is a typed wrapper over a 7-bit code value (`0x00`–`0x7F`), and the `.ascii` accessor surfaces ASCII operations and constants on `UInt8` itself. Classification and serialization work on `ASCII.Code` directly; the Standard Library Integration product adds `Sequence<UInt8>` forwarders so raw byte buffers (network frames, file reads) flow through unchanged.

```swift
import ASCII

// Classify a byte through the `.ascii` accessor.
let byte: UInt8 = 0x41
byte.ascii.isLetter        // true
byte.ascii.isUppercase     // true

// Named constants resolve to the caller-side type.
let space = UInt8.ascii.sp     // 0x20
let capA = ASCII.Character.Graphic.A   // 0x41

// A typed code point with validation.
let code = try ASCII.Code(Byte(0x7A))  // 'z'
code.isLowercase           // true
```

```swift
import ASCII
import ASCII_Standard_Library_Integration

// Classify whole byte sequences.
ASCII.Classification.isAllDigits(Array("0123".utf8))    // true
ASCII.Classification.isAllLetters(Array("Hello".utf8))  // true

// Serialize an integer to ASCII decimal bytes.
var buffer: [UInt8] = []
ASCII.Serialization.serializeDecimal(42, into: &buffer)
// buffer == [0x34, 0x32]  // "42"
```

`ASCII` is a pure namespace enum; its nested `Character.Control`, `Character.Graphic`, and `SPACE` types mirror the standard's structure. `ASCII.Code` conforms to `Byte.Protocol` from swift-byte, making it a peer byte-domain type alongside `Byte`.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-molecules/swift-ascii.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "ASCII", package: "swift-ascii"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

Two library products; depends only on swift-byte.

| Product | Target | Purpose |
|---------|--------|---------|
| `ASCII` | `Sources/ASCII/` | The `ASCII` namespace, the typed `ASCII.Code` carrier (with `Byte.Protocol` conformance), the full INCITS 4-1986 constant set, and `Classification` / `Case.Conversion` / `Parsing` / `Serialization` operations keyed on `ASCII.Code`. |
| `ASCII Standard Library Integration` | `Sources/ASCII Standard Library Integration/` | `Sequence<UInt8>` forwarders for the classification, case-conversion, and serialization operations, bridging raw byte buffers to the `ASCII.Code` API. |

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |
| Swift Embedded | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
