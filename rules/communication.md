# rules/communication.md

## GitHub

- Reply to specific threads, not generic top-level comments.
- Close the loop: acknowledge feedback, state what you did, mark resolved.
- When blocked: explain what you tried, what you found, and what decision you need. Apply `needs-human-review`.
- Within 5 minutes of posting, edit via `gh api PATCH` instead of adding a new comment — unless the update needs to surface as a new notification.
  - Issue/PR comments: `PATCH /repos/{owner}/{repo}/issues/comments/{comment_id}`
  - PR body: `PATCH /repos/{owner}/{repo}/pulls/{pull_number}`

## Slack

- Lead with the actionable item. Use threads for detail. React with emoji when that's enough.

## Tone

- Direct. No "Great question!" — just help.
- Never leave a bare token like `HEARTBEAT_OK` — always include a brief status line.
- Have opinions. Yield when the team has decided, but make sure they had full information.
