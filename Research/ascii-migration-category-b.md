# Category B ASCII Migration — Consolidated Plan

<!--
---
version: 1.0.0
last_updated: 2026-04-08
status: PLAN (blocked on Open Question 1)
scope: 22 L2 standards packages → drop swift-ascii (L3) dependency
supersedes:
  - swift-primitives/swift-ascii-primitives/Research/HANDOFF.md (this file's predecessor)
  - swift-institute/Research/handoff-ascii-domain-ownership-audit.md
  - swift-institute/Research/ascii-domain-ownership-audit.md (partial — implementation-complete audit)
  - swift-institute/Research/ascii-parsing-domain-ownership.md (partial — Category B phasing)
  - swift-institute/Research/ascii-parsing-adversarial-review.md (partial — validation history retained)
  - swift-institute/Research/ascii-serialization-migration.md (partial — full witness migration deferred, retained)
---
-->

## Goal

Prepare the Swift Institute ecosystem for releasing **swift-file-system** as a
consumable SwiftPM package. The release-readiness rule is:

> **Standards (L2) depend on Primitives (L1) solely.**
> **Foundations (L3) depend on Standards (L2) or Primitives (L1).**

22 Category B standards packages still depend on `swift-ascii` (L3) via
`Binary.ASCII.Serializable` and/or 5 additional L3 ASCII features. This plan
takes them to L1-only.

**This plan is BLOCKED on user resolution of [Open Question 1](#open-questions).
No package code changes until it is resolved.**

---

## Scope

**In scope**
- 22 Category B L2 standards packages (see [Package Inventory](#category-b-package-inventory))
- The 5 L3 ASCII features that block those packages (see [Blocking Feature Inventory](#blocking-feature-inventory))
- `Binary.ASCII.Serializable` protocol + convenience extensions relocation to L1
- Cycle 2 from the release roadmap (`swift-iso-9945` → `swift-ascii`) — folded in as package #22

**Out of scope**
- Category A packages (24 L2, already done — ~4,500 tests passing)
- Cycle 1 (`swift-rfc-4648` → `swift-ascii`) — DONE, verified at `swift-ietf/swift-rfc-4648/Package.swift:19-29`
- Cycle 3 (`swift-linux`/`swift-windows` → `swift-systems`) — NOT A CYCLE (already acyclic via Linux System / Linux Kernel split)
- Full `Binary.ASCII.Serializable` → `Parseable`/`Serializable` witness migration — DEFERRED post-release (tracked separately in [`ascii-serialization-migration.md`](../../../swift-institute/Research/ascii-serialization-migration.md))
- `swift-ascii` (L3) Machine IR restructuring — DEFERRED (separate concern)

---

## Current State

### What's done (verified 2026-04-08)

| Area | State | Evidence |
|---|---|---|
| Category A (24 pkgs) | Complete | ~4,500 tests passing, zero failures |
| `swift-file-system` itself | Clean | debug + release (`-sil-disable-pass=CopyPropagation`) + 708/708 tests pass |
| Cycle 1 | Fixed | `swift-ietf/swift-rfc-4648/Package.swift:19-29` uses `swift-ascii-primitives` (L1) |
| Cycle 3 | Not a cycle | Linux System / Linux Kernel split already breaks it |
| L1 ASCII parser infra | Exists | `swift-ascii-parser-primitives` (Tier 18): `ASCII.Decimal.Parser`, `ASCII.Hexadecimal.Parser`, `Parseable` integer conformances (10 types) |
| L1 ASCII serializer infra | Exists | `swift-ascii-serializer-primitives` (Tier 18): `ASCII.Decimal.Serializer`, `ASCII.Hexadecimal.Serializer`, `Serializable` integer conformances (10 types) |
| L1 witness infra | Exists | `Parser.Protocol`, `Parseable`, `Serializer.Protocol`, `Serializable`, `Coder.Protocol`, `Codable` all in place |
| Closing commits | Pushed | `3afe05f` in swift-file-system, `ef92761` in swift-institute |
| Handoff relocation | Done | Moved from `/Users/coen/Developer/HANDOFF.md` to `swift-primitives/swift-ascii-primitives/Research/HANDOFF.md` (commit `a4430d0`) |

### What's not done

- **Category B (22 packages)** — no migration work started post-revert
- **Cycle 2** (`swift-iso-9945` → `swift-ascii`) — folded into this migration; iso-9945 is package #22
- **Open Question 1** — destination layer for `Set.ASCII` / `[UInt8].ASCII` / `INCITS_4_1986.ASCII<C>` unresolved; this blocks the entire migration

### L1 & L2 Inventory (for locating where blocking features can move)

**L1 `swift-ascii-primitives`** (Tier 0, zero-dependency; verified prior-session inventory):

- All 128 character constants via `UInt8.ascii.*`, `ASCII.Character.Control`, `ASCII.Character.Graphic`
- `ASCII.Byte` wrapper with classification (`isLetter`, `isDigit`, `isWhitespace`, …)
- `ASCII.Case` + `ASCII.Case.Conversion` (case conversion, `convert(_:to:)`)
- `ASCII.whitespaces: Set<UInt8>` — 4 bytes (SP, HT, LF, CR)
- `ASCII.Line.Ending` enum (`.lf`, `.cr`, `.crlf`)
- `ASCII.Parsing` / `ASCII.Serialization` (byte-level digit/hex functions)
- `ASCII.Decimal`, `ASCII.Hexadecimal` (empty enum namespaces reserved for extension)
- **Does NOT provide**: `Set.ASCII` namespace, `[UInt8].ASCII` namespace, `Binary.ASCII.Serializable` protocol

**L1 `swift-ascii-parser-primitives`** (Tier 18; depends on `ascii-primitives` + `parser-primitives`):

- `ASCII.Decimal.Parser<Input, T>` conforms to `Parser.Protocol`
- `ASCII.Hexadecimal.Parser<Input, T>` conforms to `Parser.Protocol`
- `ASCII.Decimal.Error`, `ASCII.Hexadecimal.Error`
- `Parseable` conformances for all 10 stdlib integer types

**L1 `swift-ascii-serializer-primitives`** (Tier 18; depends on `ascii-primitives` + `serializer-primitives`):

- `ASCII.Decimal.Serializer<T>` conforms to `Serializer.Protocol`
- `ASCII.Hexadecimal.Serializer<T>` conforms to `Serializer.Protocol`
- `Serializable` conformances for all 10 stdlib integer types

**L2 `swift-incits-4-1986`** (depends only on L1):

- `INCITS_4_1986.ASCII<Source>` generic wrapper on byte collections and strings — provides `trimming()`, `lowercased()`, `uppercased()`, `isAllASCII`, case-insensitive comparison, `lineRanges()`, `lines()`, `detectedLineEnding()`
- `INCITS_4_1986.whitespaces` byte constant set
- `INCITS_4_1986.Character.Control.crlf` constant
- `INCITS_4_1986.convert(_:to:)` (case conversion)
- `INCITS_4_1986.Classification` batch predicates (`isAllDigits`, `isAllLetters`, …)
- `INCITS_4_1986.FormatEffectors.normalized()` (LF/CR/CRLF normalization)

**L3 `swift-ascii`** — currently owns:

- `Binary.ASCII.Serializable` (77 conformers) + `Binary.ASCII.RawRepresentable` + `Binary.ASCII.Wrapper`
- `Binary.ASCII` struct (redundant with `ASCII.Byte`)
- `Set<Character>.ascii.whitespaces` (wraps INCITS + CRLF)
- `Set<UInt8>.ascii.whitespaces` (wraps `INCITS_4_1986.whitespaces`)
- `[UInt8].ascii.crlf` (wraps `INCITS_4_1986.Character.Control.crlf`)
- Instance `.ascii` collection accessor returning `INCITS_4_1986.ASCII<Self>` wrapper
- `Binary.ASCII.equals.nulTerminated()` (stdlib-only pointer comparison)
- Machine IR parsers (`Binary.ASCII.Parsing.Machine.Decimal`) — out of scope here

---

## Key Decisions

| Decision | Rationale |
|---|---|
| **Standards depend on primitives solely.** | Non-negotiable release rule. |
| **Strategy (c) chosen: move `Binary.ASCII.Serializable` + convenience extensions to L1.** | The protocol depends only on stdlib + `Binary.Serializable` (L1); the move is architecturally clean. Proven by an earlier attempt (501 L3 tests still passed with the protocol relocated). |
| **Full `Parseable`/`Serializable` witness migration is DEFERRED.** | 77 conformers × (Parser + Serializer + conformances) ≈ 300+ file changes for zero additional release benefit. Protocol relocation unblocks the release; witness migration is post-release quality work. |
| **L2 standards MAY depend on other L2 standards.** | INCITS 4-1986 features (whitespace, case conversion) belong in `swift-incits-4-1986` (L2), not hardcoded in L1. Consumer L2 packages that need them may take an L2→L2 dep. |
| **Preserve call-site syntax.** | Move infrastructure to the right layer; never inline byte literals or rewrite with manual loops. Inline replacements like `[0x0D, 0x0A]` for `[UInt8].ascii.crlf` were explicitly rejected. |
| **Domains as namespaces, capabilities as nested types.** | Inherited from `ascii-parsing-domain-ownership.md` v4.2.0: `ASCII.Decimal.Parser` (not `Parser.ASCII.Decimal`); empty enum namespaces keep room for sibling capabilities. |

---

## Category B Package Inventory

Verify each against current git state before touching — some may have been touched by unrelated work.

| # | Package | Location | Dep type | Prior attempt status | Blocker |
|--:|---|---|---|---|---|
|  1 | swift-rfc-791 | `swift-ietf/swift-rfc-791` | protocol only | OK | — |
|  2 | swift-rfc-1035 | `swift-ietf/swift-rfc-1035` | protocol only | OK | — |
|  3 | swift-rfc-1123 | `swift-ietf/swift-rfc-1123` | protocol only | OK | — |
|  4 | swift-rfc-2369 | `swift-ietf/swift-rfc-2369` | protocol only | OK | — |
|  5 | swift-rfc-2822 | `swift-ietf/swift-rfc-2822` | protocol only | OK | — |
|  6 | swift-rfc-3339 | `swift-ietf/swift-rfc-3339` | protocol only | OK | — |
|  7 | swift-rfc-3986 | `swift-ietf/swift-rfc-3986` | protocol only | OK | — |
|  8 | swift-rfc-3987 | `swift-ietf/swift-rfc-3987` | protocol only | OK | — |
|  9 | swift-rfc-4007 | `swift-ietf/swift-rfc-4007` | protocol only | OK | — |
| 10 | swift-rfc-4291 | `swift-ietf/swift-rfc-4291` | protocol only | OK | — |
| 11 | swift-rfc-7519 | `swift-ietf/swift-rfc-7519` | protocol only | OK | — |
| 12 | swift-rfc-7617 | `swift-ietf/swift-rfc-7617` | protocol only | OK | — |
| 13 | swift-rfc-9557 | `swift-ietf/swift-rfc-9557` | protocol only | OK | — |
| 14 | swift-rfc-2045 | `swift-ietf/swift-rfc-2045` | protocol + features | FAIL | `.ascii.whitespaces`, `.ascii.trimming()`, `.ascii.lowercased()` |
| 15 | swift-rfc-2183 | `swift-ietf/swift-rfc-2183` | protocol + features | FAIL | `.ascii.whitespaces`, `.ascii.trimming()` |
| 16 | swift-rfc-2387 | `swift-ietf/swift-rfc-2387` | protocol + features | FAIL | (shares 5321/5322 lineage — re-verify) |
| 17 | swift-rfc-5321 | `swift-ietf/swift-rfc-5321` | protocol + features | FAIL | `Set<Character>.ascii.whitespaces` |
| 18 | swift-rfc-5322 | `swift-ietf/swift-rfc-5322` | protocol + features | FAIL | `Set<Character>.ascii.whitespaces`, `[UInt8].ascii.crlf` |
| 19 | swift-rfc-6068 | `swift-ietf/swift-rfc-6068` | protocol + transitive | FAIL | via 5321/5322 |
| 20 | swift-rfc-6531 | `swift-ietf/swift-rfc-6531` | protocol + transitive | FAIL | via 5321/5322 |
| 21 | swift-iso-9945 | `swift-iso/swift-iso-9945` | feature only | FAIL | `Binary.ASCII.equals.nulTerminated` (Cycle 2) |
| 22 | swift-whatwg-url | `swift-whatwg/swift-whatwg-url` | unknown | NOT BUILT | unknown; prior attempt didn't finish build |

**Prior-attempt build results**: 13 pure-protocol packages built OK; 8 failed on the 5 blocking features (including 2 transitive); iso-9945 failed on `nulTerminated`; whatwg-url not built. The prior attempt was **fully reverted** — these packages still depend on `swift-ascii` (L3) as of this plan's date.

**Verification gap**: the per-package status above is from the pre-revert snapshot. Re-verify each package's current `Package.swift` dep on `swift-ascii` before starting migration (grep `import ASCII`, `\.ascii\.`, `Binary\.ASCII\.`).

---

## Blocking Feature Inventory

The 5 L3 ASCII features that must relocate (or be reached via a different path) before the 8 feature-blocked packages can migrate. Source file lines verified in a prior session against current `swift-ascii` code.

| # | Feature | Used by | Defined in (L3) | Underlying dependency |
|---|---|---|---|---|
| F1 | `Set<Character>.ascii.whitespaces` | rfc-5321, 5322, 2045, 2183, 6531 | `Set Character+INCITS_4_1986.swift:45` | L2 `INCITS_4_1986.whitespaces` + F3 |
| F2 | `Set<UInt8>.ascii.whitespaces` | rfc-2045, 2183 (via `.trimming()`) | `Set UInt8+INCITS_4_1986.swift:23` | L2 `INCITS_4_1986.whitespaces` |
| F3 | `[UInt8].ascii.crlf` | rfc-5322, 2046 | `[UInt8]+INCITS_4_1986.swift:236` | L2 `INCITS_4_1986.Character.Control.crlf` |
| F4 | `bytes.ascii.trimming()` / `.lowercased()` | rfc-2045 | **Already L2**: `INCITS_4_1986.ASCII.swift:124-169` | stdlib + L2 `INCITS_4_1986.convert` |
| F5 | `Binary.ASCII.equals.nulTerminated()` | iso-9945 | `Binary.ASCII.Equals+nulTerminated.swift:43` | **stdlib only** (UnsafePointer, StaticString) |

**Key observations**:

- **F4 is not really L3.** The `INCITS_4_1986.ASCII<Source>` wrapper type already lives in L2 (`swift-incits-4-1986`). L3 only provides the `.ascii` *accessor* on collections that returns this wrapper. The wrapper + methods are L2 already.
- **F5 has zero external dependencies.** Stdlib-only pointer comparison — trivially movable to L1.
- **F1–F3 wrap L2 constants but are themselves defined as L3 extensions on stdlib collection types.** The underlying constants (`INCITS_4_1986.whitespaces`, `INCITS_4_1986.Character.Control.crlf`) are already at L2. Alternately, **L1 already has equivalent byte constants**: `ASCII.whitespaces: Set<UInt8>` (same 4 bytes), `ASCII.Character.Control.cr`/`.lf`. So F1–F3 can be rehomed at L1 *or* L2 depending on the preferred dependency shape.

---

## Dead Ends

Both were attempted and reverted.

### DE1 — Moving only the protocol without its ecosystem

The initial attempt moved `Binary.ASCII.Serializable`, `Binary.ASCII.RawRepresentable`, and convenience extensions to a new L1 target `ASCII Serializable Primitives` in `swift-ascii-serializer-primitives`. **The protocol itself moved cleanly** — L3 build passed, 501 L3 tests passed, re-exports worked. But migrating the 22 consumers surfaced the 5 blocking features above, which were not anticipated in the original survey.

Then, trying to move `Set.ascii`/`[UInt8].ascii` namespaces to L1 triggered **namespace conflicts**:

- L3 already defined `extension Set { public enum ASCII {} }` on generic `Set<Element>`. When L1 also defined this, the `@_exported import` from L1 through L3 produced `'ascii' is ambiguous`.
- Instance `[UInt8].ascii` (returning `INCITS_4_1986.ASCII<Self>` wrapper, L3) shadows static `[UInt8].ascii` (L1 namespace). Adding a **second** instance `.ascii` at L1 would collide.

The fix is the **atomic-swap pattern**: define at one layer only, extend at the other, with the L3 declaration removed in the same build-graph-visible change that adds the L1/L2 declaration. This was not attempted before the revert.

### DE2 — Inlining replacements at call sites

Rewriting `.trimming(.ascii.whitespaces)` as `.trimming(where: \.isWhitespace)` and `[UInt8].ascii.crlf` as `[0x0D, 0x0A]` was explicitly rejected by the user. The ecosystem uses named constants exclusively; inline hex bytes and manual loops violate the design philosophy. Any proposed fix must preserve the named-constant call-site form (or an equivalent named form from the new layer).

---

## Architecture Context

### The three-domain architecture (Parser / Serializer / Coder)

From `transformation-domain-architecture.md` (DECISION, v3.2.0) — inherited, not re-derived here:

```
swift-parser-primitives      — Parser.Protocol, Parser.Printer, Parser.ParserPrinter, Parseable
swift-serializer-primitives  — Serializer.Protocol, @Serializer.Builder, Serializable
swift-coder-primitives       — Coder.Protocol, Codable (shadows stdlib)
```

- Parser ↔ Printer are structural duals (same package).
- Serializer has no dual (own package).
- Coder is independent (separate decode/encode input and failure types).
- Three complementary strategies: **capability protocols** (types that ARE parsers/serializers), **witness types** (types that HAVE parsing/serialization), **domain protocols** (types that CONFORM to format contracts).

### Domain ownership: domains as namespaces

From `ascii-parsing-domain-ownership.md` v4.2.0 (RECOMMENDATION). **Principle**: a domain namespace SHOULD NOT be consumed by a single capability type. When a domain has or may have multiple capabilities, each is a nested type within the domain namespace.

```swift
// Correct (subject-first, open namespace):
ASCII.Decimal.Parser<Input, T>
ASCII.Decimal.Serializer<T>
ASCII.Decimal.Error
ASCII.Decimal.Machine       // L3 extension

// Wrong (capability-first or conflated):
Parser.ASCII.Integer.Decimal<Input, T>   // capability owns domain
ASCII.Decimal<Input, T>                  // domain struct IS the parser
```

**Degenerate exception**: when serialization is simple enough to not require structured namespace siblings (e.g. LEB128's `[UInt8](leb128:)` collection initializers), the domain type MAY directly conform to `Parser.Protocol` (`Binary.LEB128.Unsigned<T>`). The adversarial review (v2.0.0) corrected the original misstatement that "LEB128 has no serialization counterpart" — the correct criterion is *no structured serialization concern requiring namespace siblings*, not *no serialization at all*.

**Capability-type naming**: noun form (`.Parser`, `.Serializer`), not verb form (`.Parse`, `.Serialize`). Standards convention is split 22/25 between `.Parse` and `.Parser`; the ecosystem adopts `.Parser` as a design choice (type names describe what a type IS, not what it DOES).

---

## Strategy (c) Execution Plan

**This plan executes only AFTER [Open Question 1](#open-questions) is resolved by the user.** Steps 1–4 are sequenced by architectural dependency, not by difficulty.

### Step 0 — Verify current state (no code changes)

- [ ] Grep each of the 22 packages for `import ASCII`, `\.ascii\.`, `Binary\.ASCII\.` against current HEAD; update the Package Inventory status column.
- [ ] Re-verify the L1 witness infrastructure listed in [Current State](#current-state) still builds clean (no builds without user approval).
- [ ] Re-verify the 5 blocking features still live where the inventory says they do.

### Step 1 — Resolve destination layers per Open Question 1

Per the user's resolution, decide where each item lives. (Options enumerated in [Open Questions](#open-questions).) Record decisions inline here, then proceed.

### Step 2 — Move features bottom-up (L1 first, then L2, then protocol)

Move in this order so that later steps can depend on earlier ones. Each sub-step is a separate commit.

- [ ] **2a.** Move `Binary.ASCII.equals.nulTerminated()` to L1 (stdlib-only; trivial).
- [ ] **2b.** Per OQ1 resolution: add `Set.ASCII` namespace + `Set<UInt8>.ascii.whitespaces`, `Set<Character>.ascii.whitespaces` at the chosen layer, with atomic removal from L3 in the same commit.
- [ ] **2c.** Per OQ1 resolution: add `[UInt8].ASCII` static namespace + `.crlf`/`.cr`/`.lf` at the chosen layer, with atomic removal from L3 in the same commit.
- [ ] **2d.** Per OQ1 resolution: decide the instance `.ascii` collection accessor's new home (likely L2, since it already returns an L2 wrapper). Atomic swap.
- [ ] **2e.** Move `Binary.ASCII.Serializable` + `Binary.ASCII.RawRepresentable` + convenience extensions to L1 in a new `ASCII Serializable Primitives` target of `swift-ascii-serializer-primitives`. L3 `swift-ascii` re-exports from L1 (no conformer churn). Proven to work before the revert.

After each step: build L1 + L3 in isolation (ask before building).

### Step 3 — Migrate the 13 pure-protocol-usage packages

- [ ] For each of: rfc-791, 1035, 1123, 2369, 2822, 3339, 3986, 3987, 4007, 4291, 7519, 7617, 9557 — swap `swift-ascii` (L3) dep for L1 (`ASCII Serializable Primitives`) + update imports. Build + test per package (ask before building).

### Step 4 — Migrate the 8 feature-blocked packages

- [ ] rfc-2045, 2183, 2387, 5321, 5322 — L1 (protocol) + whichever layer(s) OQ1 designates for F1–F4.
- [ ] rfc-6068, 6531 — transitive via 5321/5322; should resolve once those are done.
- [ ] iso-9945 — L1 (F5).
- [ ] whatwg-url — verify deps, then migrate.

After each package: build + test (ask before building).

### Step 5 — End-to-end release verification

- [ ] Clean build of `swift-file-system` against migrated deps.
- [ ] 708/708 tests still pass.
- [ ] Remember the CopyPropagation workaround: release builds need `-Xswiftc -Xllvm -Xswiftc -sil-disable-pass=CopyPropagation` (unrelated to this work, but will surface during verification).

### Step 6 — Close Cycle 2 / update release roadmap

- [ ] Cross off Cycle 2 in `swift-institute/Research/release-roadmap-swift-file-system.md` §3.
- [ ] Update this plan's status to DONE.

---

## Open Questions

### OQ1 — Destination layer for `Set.ASCII` / `[UInt8].ASCII` / `INCITS_4_1986.ASCII<C>` wrapper

**BLOCKING.** This is the specific question that caused the prior revert. The user must choose before any code moves.

The options form two axes: *which namespaces go to L1 vs L2*, and *how the `INCITS_4_1986.ASCII<C>` wrapper is reached from the 8 feature-blocked packages*.

**Options for namespaces (`Set.ASCII`, `[UInt8].ASCII`) and their whitespace/CRLF constants**:

| Option | Where `Set.ASCII` & `[UInt8].ASCII` live | What they wrap | Trade-off |
|---|---|---|---|
| **A** | L1 (`ascii-primitives` extensions) | L1 constants (`ASCII.whitespaces`, `ASCII.Character.Control.cr/.lf`) | Self-contained L1. No L1→L2 back-reference. Drops the *symbolic* link between the rfc consumers' whitespace set and the INCITS spec, because L1 has its own copy. |
| **B** | L2 (`swift-incits-4-1986` extensions on stdlib types) | L2 constants (`INCITS_4_1986.whitespaces`, `INCITS_4_1986.Character.Control.crlf`) | Preserves the INCITS spec provenance. Forces the 8 feature-blocked packages to take an L2→L2 dep on `swift-incits-4-1986` (allowed per key decisions). |
| **C** | Split: `Set.ASCII` in L1, instance `[UInt8].ascii` collection accessor in L2 | Mix | The cleanest split by *ownership* but two layers to reason about. |

**Options for the `INCITS_4_1986.ASCII<C>` wrapper** (used by F4 — `bytes.ascii.trimming()` / `.lowercased()`):

| Option | Approach | Trade-off |
|---|---|---|
| **α** | Leave the wrapper in L2 where it already lives; rfc-2045 takes an L2→L2 dep; the instance `.ascii` accessor is reached via that L2 package (not L3 swift-ascii). | Minimal change to L2; requires extending the accessor definition to live in L2. Atomic swap needed with L3's current definition. |
| **β** | Move the wrapper to L1 with self-contained byte-level operations (no INCITS dep). | L1 gains a non-trivial wrapper type; duplicates what L2 already has. |
| **γ** | Define a *lighter* L1 wrapper type with just `.trimming()` + `.lowercased()`; leave the richer `INCITS_4_1986.ASCII<C>` in L2. | Two wrappers for the same concept — high drift risk. |

**Recommendation (not a decision)**: **B + α**. Features defined by INCITS 4-1986 belong in the spec package; L2→L2 deps are explicitly allowed; the rich wrapper already lives there. L1 stays minimal and spec-agnostic. But the user's judgment is required — this has non-obvious trade-offs around release surface and re-export topology.

**Constraint for whichever option wins**: the L3 `swift-ascii` declarations must be removed **atomically** with the L1/L2 additions (same build-graph-visible change) to avoid the `'ascii' is ambiguous` re-export conflict that caused the prior revert.

### OQ2 — Strategy (c) vs full witness migration? — RESOLVED

Resolved in favor of **Strategy (c)** in the key decisions. The full `Binary.ASCII.Serializable` → `Parseable`/`Serializable` witness migration (77 conformers × per-type Parser + Serializer + conformances + `CustomStringConvertible`) is roughly an order of magnitude more work than relocating the protocol, for zero additional release benefit. It stays tracked in [`ascii-serialization-migration.md`](../../../swift-institute/Research/ascii-serialization-migration.md) as post-release quality work.

### OQ3 — Should L3 `swift-ascii` retain these features at all, or become a re-export shell?

Follows from OQ1. After L1/L2 absorb the blocking features and the protocol, `swift-ascii` (L3) arguably still earns its keep via Machine IR, `Binary.ASCII` struct (redundant but not Category-B-blocking), and the historical `Binary.ASCII.*` namespace. A full L3 consolidation is a separate concern — not blocking release. Defer the "re-export shell or keep features?" question until after Category B is green.

---

## Constraints

- **Named constants only.** Every call site must use `[UInt8].ascii.crlf`, `.ascii.whitespaces`, etc. or the equivalent named form in the new layer. No `[0x0D, 0x0A]`, no `.trimming(where: \.isWhitespace)`.
- **77 `Binary.ASCII.Serializable` conformers** across the 22 packages. Zero external generic constraints — the protocol move itself is mechanically clean (confirmed by prior attempt).
- **`Binary.ASCII` is a struct**, not an enum, in L3 with `public let byte: UInt8`. Relocating its namespace to L1 requires L3 to remove its declaration and *extend* the L1 type.
- **`Set.ASCII` namespace conflict** — must be defined at ONE layer only; extended at the other. This is the specific error the prior revert hit.
- **Instance vs static `.ascii` on `[UInt8]`** — L1 has `static var ascii` (namespace), L3 has `var ascii` (instance wrapper). Both can coexist today; do not add a second instance `.ascii` at L1.
- **CopyPropagation crash (Swift 6.3)** — release builds across the workspace need `-Xswiftc -Xllvm -Xswiftc -sil-disable-pass=CopyPropagation`. Unrelated but will surface during end-to-end verification.
- **Ask before `swift build` or `swift test`** — per user preference.

---

## Related Work (not absorbed)

- **[`release-roadmap-swift-file-system.md`](../../../swift-institute/Research/release-roadmap-swift-file-system.md) §3** — where the Category B migration was originally identified as the resolution for Cycles 1 & 2. Category B completion closes Cycle 2 and unblocks Phase 2 of the roadmap.
- **[`ascii-serialization-migration.md`](../../../swift-institute/Research/ascii-serialization-migration.md)** — the full 8-phase `Parseable`/`Serializable` witness migration plan. DEFERRED post-release. Still the canonical plan for that work; this Category B plan explicitly does NOT supersede it for the migration itself.

---

## Superseded Sources (in swift-institute/Research/)

The following documents are superseded by this plan for Category B scope. Each has a header note pointing here.

| Source | Supersession scope |
|---|---|
| `swift-primitives/swift-ascii-primitives/Research/HANDOFF.md` | FULL — precursor to this plan; content absorbed. |
| `swift-institute/Research/handoff-ascii-domain-ownership-audit.md` | FULL — historical prior handoff (ASCII domain ownership); post-implementation, superseded by the audit below plus this plan. |
| `swift-institute/Research/ascii-domain-ownership-audit.md` | FULL — implementation audit of the Parser/Serializer split (Steps 0-5 on 2026-03-05); findings are either done or deferred, not Category-B-actionable. |
| `swift-institute/Research/ascii-parsing-domain-ownership.md` v4.2.0 | PARTIAL — the architectural principle ("domains as namespaces") is summarized in [Architecture Context](#architecture-context); the migration phasing is superseded. The broader document retains value for namespace design rationale. |
| `swift-institute/Research/ascii-parsing-adversarial-review.md` v2.0.0 | PARTIAL — retained as validation history for the domain-ownership decisions. Not a migration source. |
| `swift-institute/Research/ascii-serialization-migration.md` v2.0.0 | PARTIAL — the deferred full witness migration; this plan explicitly does NOT supersede its scope. |
| `swift-institute/Research/audits/implementation-naming-2026-03-20/swift-ascii-primitives.md` | TANGENTIAL — L1 naming audit (16 findings). Largely addressed per `Reflections/2026-04-03-pre-publication-audit-fixes-complete.md`. Not Category-B-actionable. |
| `swift-institute/Research/Reflections/2026-04-03-pre-publication-audit-fixes-complete.md` | TANGENTIAL — context for prior audit fixes touching swift-ascii. |
| `swift-institute/Research/Reflections/2026-04-04-darwin-primitives-kernel-narrowing.md` | TANGENTIAL — flags a latent MIV issue in `swift-ascii-parser-primitives` (action item carried forward: re-check `ASCII.Decimal.Parser` / `ASCII.Hexadecimal.Parser` for similar issues during Step 0). |

---

## Changelog

- **v1.0.0** (2026-04-08) — Initial consolidation. Absorbed HANDOFF.md (at its new location in `swift-primitives/swift-ascii-primitives/Research/`) and the scattered research sources listed above. Plan is BLOCKED on OQ1 resolution; no code changes until user decides where `Set.ASCII`, `[UInt8].ASCII`, and the `INCITS_4_1986.ASCII<C>` wrapper should live.
