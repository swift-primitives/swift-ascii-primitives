# Handoff: Category B ASCII Migration (L2 Standards → L1 Primitives)

> **SUPERSEDED** (2026-04-08) — consolidated into
> [`ascii-migration-category-b.md`](ascii-migration-category-b.md) in this directory.
> That plan absorbs this handoff's scope, dead ends, package inventory, and open
> questions. Original content retained below for history.

> To resume: read this file, then consolidate the scattered source documents
> listed below into a single coherent plan at
> `swift-primitives/swift-ascii-primitives/Research/ascii-migration-category-b.md`
> (same directory as this handoff) BEFORE starting any code changes. Verify
> the current state of each package against git, not against the memory of
> prior attempts.

## Goal

Prepare the Swift Institute ecosystem for releasing `swift-file-system` as a
consumable SwiftPM package. The release-readiness rule: **standards (L2)
depend on primitives (L1) solely; foundations (L3) depend on standards or
primitives.** 22 Category B standards packages still depend on `swift-ascii`
(L3) via `Binary.ASCII.Serializable` and/or 5 other L3 ASCII features. The
architectural rule is non-negotiable for release.

## Current State

**In scope (this handoff):**
- **Category B — NOT STARTED.** 22 packages still depend on `swift-ascii`. A
  prior migration attempt was fully reverted after discovering the scope was
  larger than anticipated (see Dead Ends). All repos are clean.

**Out of scope but resolved (context):**
- **Category A COMPLETE** — 24 packages, ~4,500 tests passing, zero failures.
- **swift-file-system itself is clean** — debug build, release build
  (`-sil-disable-pass=CopyPropagation`), and `swift test` (708/708) all pass
  as of 2026-04-08.
- **Cycle 1** (swift-rfc-4648 → swift-ascii) — DONE. Package.swift now uses
  `swift-ascii-primitives` (L1). Verified at `swift-ietf/swift-rfc-4648/Package.swift:19-29`.
- **Cycle 3** (swift-linux/swift-windows → swift-systems) — NOT A CYCLE. The
  target graph is already acyclic via the `Linux System` / `Linux Kernel`
  split pattern. No action required.
- **Cycle 2** (swift-iso-9945 → swift-ascii) — OPEN, but it is a subset of
  this Category B work. iso-9945 is package #22 in the list, and its sole
  usage is `Binary.ASCII.equals.nulTerminated` — one of the 5 extra features.
  Fix as part of this migration, not separately.

## Key Decisions

- **Standards depend on primitives solely.** Non-negotiable release rule.
- **Strategy (c) chosen: move the `Binary.ASCII.Serializable` protocol + its
  convenience extensions to L1** in a new `swift-ascii-serializer-primitives`
  target. The protocol depends only on stdlib + `Binary.Serializable` (L1),
  so the move is architecturally clean. The full Parseable/Serializable
  witness migration is deferred.
- **L2 standards MAY depend on other L2 standards.** Features defined by
  INCITS 4-1986 (whitespace, case conversion, character classification)
  belong in `swift-incits-4-1986` (L2), not hardcoded in L1 `ascii-primitives`.
- **Preserve call-site syntax.** Move infrastructure to the right layer;
  never inline byte literals or rewrite with manual loops. User explicitly
  rejected replacements like `[0x0A]` in favor of `[UInt8].ascii.lf`.

## Dead Ends

1. **Moving only the protocol without its ecosystem** — the initial attempt
   moved `Binary.ASCII.Serializable` + `Binary.ASCII.RawRepresentable` +
   convenience extensions to L1. Protocol moved cleanly (501 L3 tests passed),
   but migrating the 22 consumers surfaced **5 additional L3 ASCII features**:

   | Feature | Used by | Defined in (L3) |
   |---|---|---|
   | `Set<Character>.ascii.whitespaces` | rfc-5321, 5322, 2045, 2183, 6531 | `Set Character+INCITS_4_1986.swift` |
   | `Set<UInt8>.ascii.whitespaces` | rfc-2045, 2183 (via `.trimming()`) | `Set UInt8+INCITS_4_1986.swift` |
   | `[UInt8].ascii.crlf` | rfc-5322, 2046 | `[UInt8]+INCITS_4_1986.swift` |
   | `bytes.ascii.trimming()` / `.lowercased()` | rfc-2045 | `INCITS_4_1986.ASCII<C>` wrapper |
   | `Binary.ASCII.equals.nulTerminated()` | iso-9945 | `Binary.ASCII.Equals.swift` |

   Moving `Set.ascii` / `[UInt8].ascii` to L1 caused namespace conflicts
   (L3 also defines `.ascii` on generic `Set<Element>` / `[UInt8]`,
   re-export yields `'ascii' is ambiguous`; instance `.ascii` shadows static
   `.ascii`). Reverted.

2. **Inlining replacements at call sites** — `.trimming(.ascii.whitespaces)`
   → `.trimming(where: \.isWhitespace)`, `[UInt8].ascii.crlf` →
   `[0x0D, 0x0A]`, etc. Rejected by user: the ecosystem uses named constants
   exclusively.

## Source Documents to Consolidate

The next session's **first task** is to locate, read, and consolidate the
following scattered documents into a single coherent plan at
`/Users/coen/Developer/swift-primitives/swift-ascii-primitives/Research/ascii-migration-category-b.md`
(alongside this handoff). The consolidated document supersedes all sources;
after consolidation, delete the sources or mark them superseded with a
pointer to the consolidated doc.

**This handoff (predecessor content)**:
- `swift-primitives/swift-ascii-primitives/Research/HANDOFF.md` — this file;
  its Category A/B split, dead ends, architectural principle, and Category B
  package list ARE the seed content for the consolidated plan.

**Research directory** (`swift-institute/Research/`):
- `ascii-serialization-migration.md` — the referenced 8-phase witness
  migration plan (479 lines; Phase 1 L1 infrastructure is stated complete)
- `ascii-domain-ownership-audit.md` — 244 lines
- `handoff-ascii-domain-ownership-audit.md` — 292 lines; an earlier handoff
- `ascii-parsing-adversarial-review.md` — 371 lines
- `ascii-parsing-domain-ownership.md` — 743 lines
- `ascii-parsing-domain-ownership.md` (same) — part of the domain ownership series
- `audits/implementation-naming-2026-03-20/swift-ascii-primitives.md` — L1 naming audit

**Reflections** (`swift-institute/Research/Reflections/`):
- `_index.md` — scan for ASCII entries
- `2026-04-03-pre-publication-audit-fixes-complete.md` — may reference prior
  state
- `2026-04-04-darwin-primitives-kernel-narrowing.md` — tangential but mentions
  ASCII

**Release roadmap** (tangentially related, do NOT absorb — just link):
- `swift-institute/Research/release-roadmap-swift-file-system.md` §3 (Phase 0
  checklist references this migration)

## Category B Packages (22)

Verify each against current git state before touching — some may have been
touched by unrelated work.

- **IETF (20)**: rfc-791, 1035, 1123, 2045, 2183, 2369, 2387, 2822, 3339,
  3986, 3987, 4007, 4291, 5321, 5322, 6068, 6531, 7519, 7617, 9557
- **ISO (1)**: iso-9945 (also Cycle 2 in release roadmap §3)
- **WHATWG (1)**: whatwg-url

Package locations: IETF at `/Users/coen/Developer/swift-ietf/swift-rfc-*`,
ISO at `/Users/coen/Developer/swift-iso/swift-iso-9945`, WHATWG at
`/Users/coen/Developer/swift-whatwg/swift-whatwg-url`.

Prior migration attempt build results (before revert):

| Status | Packages | Blocker |
|---|---|---|
| OK (13) | 791, 1035, 1123, 2369, 2822, 3339, 3986, 3987, 4007, 4291, 7519, 7617, 9557 | pure protocol usage |
| FAIL (5) | 2045, 2183, 2387, 5321, 5322 | the 5 extra features |
| FAIL (2) | 6068, 6531 | transitive via 5321/5322 |
| FAIL (1) | iso-9945 | `Binary.ASCII.equals.nulTerminated` |
| Not built | whatwg-url | unknown |

## Changed Files

None in scope for this handoff. (The sibling commits `3afe05f` in
swift-file-system and `ef92761` in swift-institute closed out the
unrelated Cycle 1/3 / test-fix / roadmap work.)

## Open Questions

1. **Where do `Set.ASCII`, `[UInt8].ASCII`, and the `INCITS_4_1986.ASCII<C>`
   wrapper live?** Options: (a) move wrapper to L1 with self-contained
   byte-level ops; (b) have rfc-2045 depend on INCITS directly (L2→L2,
   allowed); (c) define a lighter L1 wrapper. The consolidated plan must
   pick one.
2. **Protocol move or full witness migration?** The L1 witness infrastructure
   (`Serializer.Protocol`, `Serializable`, `Parser.Protocol`, `Parseable`,
   `Coder.Protocol`, integer conformances) is reportedly complete — verify
   against current code. 77 conformers across the 22 packages; transformation
   is mechanical per-type but high volume.
3. **Should L3 `swift-ascii` retain these features at all?** After L1/L2
   consolidation, does the L3 package still earn its name, or does it become
   a re-export shell?

## Next Steps

1. **Consolidate source documents** (no code changes). Read every file in
   "Source Documents to Consolidate". Write the merged plan to
   `swift-institute/Research/ascii-migration-category-b.md`. Mark each source
   superseded (either delete or add a header pointing to the consolidated
   doc). Commit this alone so the consolidation is reviewable.

2. **Verify current state** — grep each of the 22 packages for `import ASCII`,
   `\.ascii\.`, `Binary\.ASCII\.`, and cross-reference against the 5-feature
   inventory. Update the per-package status table in the consolidated plan.
   Check whether the L1 witness infrastructure in
   `ascii-serialization-migration.md` is in fact complete (the plan claims
   it is, but this hasn't been re-verified post-revert).

3. **Resolve Open Question 1** (where `Set.ASCII` / `[UInt8].ASCII` /
   `INCITS_4_1986.ASCII<C>` live) with the user before touching any package.
   This was the specific blocker that forced the prior revert.

4. **Move bottom-up** per the architectural principle: spec-defined features
   into spec packages (INCITS 4-1986), pure-byte features into L1, then the
   protocol. Do NOT skip ahead to per-package migration until the L1/L2
   destination layers are stable.

5. **Migrate Category B packages** in dependency order. Start with the 13
   pure-protocol-usage packages, then tackle the 5 feature-blocked ones, then
   the 2 transitive packages (6068, 6531), then iso-9945 and whatwg-url.

6. **Coordinate with Cycle 2**: iso-9945's `Binary.ASCII.equals.nulTerminated`
   fix is this work — no separate task.

## Constraints

- **User rejects inline byte literals.** Every call site must use named
  constants (`[UInt8].ascii.crlf`, `.ascii.whitespaces`, etc.) or the
  equivalent in the new layer. No `[0x0D, 0x0A]`.
- **`Binary.ASCII.Serializable` has 77 conformers** across 22 packages.
- **`Binary.ASCII` namespace is a struct** (not enum) in L3 with
  `public let byte: UInt8`. Moving to L1 requires L3 to remove its
  declaration and extend the L1 type.
- **`Set.ASCII` namespace conflict** — define at ONE layer only, extend at
  the other. This was the specific error during the prior revert.
- **Instance vs static `.ascii` on `[UInt8]`** — L1 has `static var ascii`
  (namespace), L3 has `var ascii` (instance wrapper). Both can coexist; do
  not add a second instance `.ascii` at L1.
- **CopyPropagation crash (Swift 6.3)**: release builds in the broader
  workspace need `-Xswiftc -Xllvm -Xswiftc -sil-disable-pass=CopyPropagation`.
  Unrelated to this migration but you'll hit it during end-to-end verification.
