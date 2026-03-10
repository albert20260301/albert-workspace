#!/usr/bin/env bash
# Creates or updates a GitHub issue.
# If an open issue with the given label (or matching the title) already exists,
# appends a comment. Otherwise creates a new issue.
#
# Usage:
#   bash scripts/upsert-github-issue.sh \
#     --title   "Issue title" \
#     --body    "Issue body (markdown)" \
#     --label   "some-label" \
#     [--search-by-label]   # match existing issue by label (default: match by title)
#
# Requires GH_TOKEN to be set in the environment.
#
# Referenced by: HEARTBEAT.md (steps 2.2a, 2.6), skills/routine-maintainer/SKILL.md

set -euo pipefail

TITLE=""
BODY=""
LABEL=""
SEARCH_BY_LABEL=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --title)           TITLE="$2";           shift 2 ;;
    --body)            BODY="$2";            shift 2 ;;
    --label)           LABEL="$2";           shift 2 ;;
    --search-by-label) SEARCH_BY_LABEL=true; shift   ;;
    *) echo "Unknown argument: $1" >&2; exit 1 ;;
  esac
done

if [[ -z "$TITLE" || -z "$BODY" ]]; then
  echo "Error: --title and --body are required." >&2
  exit 1
fi

if [[ "$SEARCH_BY_LABEL" == true && -n "$LABEL" ]]; then
  EXISTING=$(gh issue list \
    --label "$LABEL" \
    --state open \
    --json number \
    --jq '.[0].number // empty')
else
  EXISTING=$(gh issue list \
    --search "\"${TITLE}\" in:title" \
    --state open \
    --json number \
    --jq '.[0].number // empty')
fi

if [[ -n "$EXISTING" ]]; then
  gh issue comment "$EXISTING" --body "$BODY"
  echo "Commented on issue #${EXISTING}"
else
  CREATE_ARGS=(--title "$TITLE" --body "$BODY")
  if [[ -n "$LABEL" ]]; then
    CREATE_ARGS+=(--label "$LABEL")
  fi
  gh issue create "${CREATE_ARGS[@]}"
  echo "Created new issue: ${TITLE}"
fi
