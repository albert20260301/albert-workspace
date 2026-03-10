---
name: build-sdk
description: Generic workflow to implement an SDK against a versioned spec. Use when bootstrap-sdk dispatches to Phase 5 — read the spec from specs/<type>/SPEC.md, implement per requirements, validate, and package. Takes SDK type (product-analytics, lakehouse) as input.
---

# Build SDK

## Purpose

This skill orchestrates the implementation workflow for Altertable SDKs. It is dispatched by [bootstrap-sdk](../bootstrap-sdk/SKILL.md) during Phase 5.

Read the appropriate spec from the `specs/` submodule (or workspace `specs/` submodule when working from the workspace), implement per the requirements, validate, and package.

## Related Skills

- **[bootstrap-sdk](../bootstrap-sdk/SKILL.md)**: Fork, clone, submodule setup — dispatches here for Phase 5
- **[release-sdk](../release-sdk/SKILL.md)**: Versioning, changelog, registry publishing
- **[build-readme](../build-readme/SKILL.md)**: README conventions for SDK repos

## Inputs

- **SDK type**: `product-analytics` or `lakehouse`
- **Spec path**: `specs/<type>/SPEC.md` (relative to the SDK repo root or workspace `specs/`)

## Spec Mapping

| SDK type | Spec path | Additional files |
|---|---|---|
| `lakehouse` | `specs/lakehouse/SPEC.md` | — |
| `product-analytics` | `specs/product-analytics/SPEC.md` | `specs/product-analytics/constants.md`, `specs/product-analytics/TEST_PLAN.md`, `specs/product-analytics/fixtures/*.json` |

For HTTP transport requirements (keep-alive, timeouts, language recommendations), read `specs/http/SPEC.md` — both lakehouse and product-analytics specs reference it.

## Workflow

1. **Read the spec** at `specs/<type>/SPEC.md`. Treat it as the source of truth for requirements.
2. **Scaffold** per the spec's first phases (package structure, license, lint/test scripts).
3. **Implement** each requirement phase in order. Do not skip phases applicable to the target tier (web/mobile/server for product-analytics).
4. **Validate** before opening PR:
   - All tests pass
   - Fixtures compliance (product-analytics: `specs/product-analytics/fixtures/`)
   - Mock-backed integration tests run
5. **Package** per [release-sdk](../release-sdk/SKILL.md) — versioning, changelog, registry conventions. Generate README per [build-readme](../build-readme/SKILL.md).

**Spec update** (not initial bootstrap): use `git -C specs diff <old-tag>..<new-tag> -- .` to identify changes. Only implement what is new or modified. Document breaking changes in `CHANGELOG.md`.

## When Things Go Wrong

### OpenAPI spec unavailable

If the OpenAPI URL cannot be fetched (timeout, 404):

- **Product Analytics**: Use the reference JS implementation's types as the source of truth. Document which spec version you based the models on.
- **Lakehouse**: Use the endpoint reference in `specs/lakehouse/SPEC.md` as the source of truth.

### Missing platform APIs

Some platforms lack certain APIs (`crypto.randomUUID`, `navigator.sendBeacon`, etc.). Always provide a polyfill or fallback:

- **UUID generation**: Fall back to a manual v4 UUID implementation.
- **Beacon transport**: Fall back to `fetch` with `keepalive: true`, then plain `fetch`.
- **Storage APIs**: Follow the fallback chain in the spec. If all fail, use in-memory storage.

### Streaming parse failures (Lakehouse)

If NDJSON streaming produces unexpected line formats, fail loudly with line index and raw content in the error. Never silently drop rows.

### Tests cannot run

Integration tests use the mock server and require no live credentials. If blocked (e.g., Docker unavailable, missing Testcontainers bindings), skip with a clear `TODO` and a logged warning. Document what is skipped and why in the PR description. Do not silently omit test coverage.
