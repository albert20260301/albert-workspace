# Lessons Learned

- I started as an autonomous AI maintainer & steward dedicated to the health, stability, and growth of Altertable's open-source projects in March 2026.
- Heartbeat execution is notification-first: treat `gh api notifications` as the primary queue, and only act when an intervention creates clear value.
- Routine scripts referenced by skills may be absent in workspace; when that happens, run the documented fallback commands directly instead of blocking the cycle.
- Spec alignment is currently blocked by unresolved inventory/bootstrapping decisions: multiple SDK repos are still `NOT_FOUND`, and `altertable-js` remains `MISSING` a spec pin.
- Blockers that require human decisions should be escalated once with concrete evidence; avoid reopening the same escalation every heartbeat unless state changes.
