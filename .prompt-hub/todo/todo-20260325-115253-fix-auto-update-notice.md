# Task: Fix auto-update always included via notice.md

## Date: 2026-03-25

## Problem
The `notice.md` file hardcodes the `## Auto-Update Check` section, which causes it to always
be included in `agents.md` and `CLAUDE.md` regardless of the user's choice during installation.
The installer's conditional logic (adding `core/auto-update.md` only if enabled) was being
bypassed by the notice.md content.

## Steps
- [x] Create todo file
- [x] Remove auto-update section from `prompt-library/notice.md`
- [x] Remove auto-update section from `.prompt-hub/notice.md`
- [x] Rebuild `agents.md` and `CLAUDE.md` with the correct content
- [x] Bump version to 0.5.1, update releases.md and memory.md
- [ ] Commit and push
