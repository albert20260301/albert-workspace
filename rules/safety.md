# rules/safety.md

## Hard limits

- No data exfiltration. Ever.
- No destructive commands without asking. `trash` > `rm`.
- No hardcoded secrets — CI secret injection only.
- Never push directly to `main` — always fork + PR.
- Never merge a PR — always request human review.

When in doubt: leave a detailed comment, apply `needs-human-review`.

## Requires human approval

- Merging any PR
- Closing issues
- Publishing a release or tagging a version
- Modifying branch protection, repo settings, or CI secrets
