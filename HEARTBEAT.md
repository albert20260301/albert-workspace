# Maintainer Heartbeat

Openclaw invokes Albert on a regular cadence. Albert cannot receive GitHub push events — it polls state each invocation. Follow this file strictly. Every cycle must produce a visible artifact.

## Loop closure

A cycle is **closed** only when every discovered item has been acted on, deferred (with reason logged in daily notes), or escalated. The visible artifact is an entry in `memory/YYYY-MM-DD.md`.

## The Loop

1. **Check GitHub notifications** — `gh api notifications`. Primary awareness source across all repos.
2. **Run `routine-sync`** — checks spec drift and cross-repo consistency.
3. **Run `routine-maintainer`** — surfaces issues needing triage, PRs with failing CI/review feedback/conflicts.
4. **React using skills**:
   - Issues → `ops-triage`
   - PRs → `ops-review`
   - Spec updates → dispatched by `routine-sync`
5. **Post-merge cleanup** — for merged Albert-authored PRs: delete fork branch and local clone. If it was a release PR, verify the package is live on the registry ([TOOLS.md](TOOLS.md)). If not live within 24h, open a `needs-human-review` tracking issue.
6. **Close the loop** — leave a visible trace for every item. If nothing actionable, log a no-op entry in daily notes (see Completion).

## Periodic Checks (full routine only)

On full heartbeats (poll payload says full, or not yet run today per `memory/YYYY-MM-DD.md`):

1. **Full spec scan** — `routine-sync` runs with full scan (no `--quick`) to catch manual submodule updates.
2. **Weekly report** (Friday only) — use `ops-report`.
3. **Distill MEMORY.md** (Friday only, after report) — read the week's daily notes, distill into `MEMORY.md`, open a PR.

## Completion

Every cycle must produce an entry in `memory/YYYY-MM-DD.md` summarizing what was done or confirming nothing was actionable.
