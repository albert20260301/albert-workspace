# Contributing to albert-workspace

Changes here affect how Albert behaves across all Altertable SDK repositories.

## How to contribute

1. Fork → branch (`feat/<desc>` or `fix/<issue>-<desc>`) → PR against `main`
2. All changes are reviewed by the core team before merging

## Before opening a PR

- **Skills / SOUL.md / AGENTS.md**: Explain what behavior you're changing and why. Test skills mentally against a realistic scenario.
- **Scripts**: Verify they handle missing data, API errors, and edge cases without crashing silently.
- **CI workflows**: Require a passing run before review.

## What not to add

- Files outside the defined workspace structure
- Secrets or credentials
- `memory/` files — local-only, never committed

## Links

- [altertable-client-specs](https://github.com/altertable-ai/altertable-client-specs) — SDK specifications
- [altertable-ai org](https://github.com/altertable-ai) — all SDK repositories
